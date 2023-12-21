Return-Path: <linux-kernel+bounces-8252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C5781B47E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3487284784
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414756AB9A;
	Thu, 21 Dec 2023 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP2cKoc/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AC6A32D;
	Thu, 21 Dec 2023 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e305530baso817067e87.3;
        Thu, 21 Dec 2023 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703156176; x=1703760976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4PuTxe81bKKQPGfEt+SGtFIfBP+23nW09wPuRRMJ8w=;
        b=OP2cKoc/iTBXgOz8I3m4FGDBY09GmD89pkhUzGt8psIfNY4xBRelVrp/89OKOm85Cd
         0M4G8mBlkSfL6rdgEsRrT34TyJRCY6Y3GKu5G5pDiulWcDIu/rJQ0+05voJ+zlWOKNvG
         HpKEdT19qLSDz+r1/mbiEuVZyonUHjsW7O5SOvapmBnRXBMj7sVdhaHlLZW3kNhQl6tB
         axFWy1W9WlUUROZ4Gd3FrzsZTQH28L75pIU1LkLIY0pyLJDAIhEke4OBoNPq/pFInn4O
         7rCi/4/aKlpiboQvLi35gFZSm6LIZHE4C4qOAdkgUiq/ZcR35TqAE12S5od7gCOzbFOh
         +WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703156176; x=1703760976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4PuTxe81bKKQPGfEt+SGtFIfBP+23nW09wPuRRMJ8w=;
        b=iD9CfmeGL6ZuqJY7atPpU5CqcuZAD50gB5g5NVnnHoLatbcjGRdSIp/oDTT2HmSVvM
         KMTn80NORjZ+pSZKkA2YN0EM7NhfLrQekh4NTnsSKIXaL1IjshOyxfmU9RTvrdWGzTFE
         6QWne5LD4WIVH0b3Ykg+8TjoyWkYkYXw4m0cTMiAT92MbZXKHB1ySzDeiIiGgP9MbgRO
         NjqX+m+NqomHO2zUIBGUHn4yohNVEbq6TsxiPBqrnLZPShHSmbIwv4sbpRICSyOh7dK0
         dDJTW5mXU9PK1xKP9GDuxobEYsni1E4HeyI5x9xHPb390UbT45EnJIku5JQD7uM8QC+B
         VGSw==
X-Gm-Message-State: AOJu0Yw5zYuegwD3L1EvPBfMxglp5tP7cYdNhR6es/4/eW/sqlbdLIaz
	wlheFq/7J61lyaSADFkGP6E=
X-Google-Smtp-Source: AGHT+IGKOtPYNkSyncWKUPgbXmsCJfkgd4odNMULyfflE8j0Wm/QK3XG+NmqULPLvd+vxxSS0Mh/Xg==
X-Received: by 2002:ac2:538c:0:b0:50e:4e33:230d with SMTP id g12-20020ac2538c000000b0050e4e33230dmr1644073lfh.29.1703156176220;
        Thu, 21 Dec 2023 02:56:16 -0800 (PST)
Received: from pc636 (host-90-233-221-204.mobileonline.telia.com. [90.233.221.204])
        by smtp.gmail.com with ESMTPSA id m3-20020a195203000000b0050e38aa28e8sm239720lfb.101.2023.12.21.02.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:56:15 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 21 Dec 2023 11:56:13 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 6/7] rcu: Move sync related data to rcu_state structure
Message-ID: <ZYQZzbqZss5MJ9vl@pc636>
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-7-urezki@gmail.com>
 <664015f6-6064-4c51-8072-ff48f43ed000@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <664015f6-6064-4c51-8072-ff48f43ed000@paulmck-laptop>

On Tue, Dec 19, 2023 at 05:47:47PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 28, 2023 at 09:00:32AM +0100, Uladzislau Rezki (Sony) wrote:
> > Move synchronize_rcu() main control data under the rcu_state
> > structure. An access is done via "rcu_state" global variable.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Could we please fold this into the earlier patches?  Your future self
> might thank me.  ;-)
> 
OK. No problem, i will see which one is the most appropriate for this :)

--
Uladzislau Rezki

