Return-Path: <linux-kernel+bounces-30601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F83832193
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A426628769D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE08F51;
	Thu, 18 Jan 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGa5PxRq"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B069461;
	Thu, 18 Jan 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617163; cv=none; b=Tf8Ruh/d0gmaSr2AZgKfw9qX2b8Hi9epmng8PB+1EuIECcTRGV8X+i/2hfzIZzm7F8DDL/4MHipXZlcC4+wsXo39tmk2UwQ/CWAXeflsgt5rr8OJVVwt2w63uxl8ymcS+CcrZhlsexdvaVWPFGhK3Be9daislWTwwnQG/Kb2s+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617163; c=relaxed/simple;
	bh=M4FC5RFpU+gBs/4jHvsgu9SOSEyqfP0aIO99aZepvQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr4NbdRdKfUBBWaCTbxayntRIGb9wPAZBUuA1q7P8xVP9G+oi9WbPGlpU8iRTwVv3ePphMrWDyk7dHjyhjsCJq9h/Yli9iQbdvG3o68GPMGEcJGIgfWrn/VWDif7j0VhlfEG66J3wdxwpR85I5PZmJfUATATMCgmMp5tduHOJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGa5PxRq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d6ff29293dso1194305ad.0;
        Thu, 18 Jan 2024 14:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705617161; x=1706221961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7Ga1PrZhviwyhWdstpoS5TcnXPX4KWerzR54KDAnLM=;
        b=LGa5PxRqz4C4SSinW9SAlJj16JdIlUaH6N1tntWrc78cCgOhfiNmJmakqFHhgsdgea
         mRlbcu2Xkis6TQ2yKXhZuElxTg6HYti+9uqiLS3zbJTPnua7lXx9dB+pdRdXU21JCwQv
         Xrh/wImRXUizTkvKyFVV350ON3zUijFod8oJdNrMc+7oIQHqv/E1MKMtZ7ZjdpZFJSjy
         m5Fnwx8l3NS7YTkJ4opOcGYdBkiVMe48jdILEtl3l5OJbdahy24gLzGAnH3uCDbkwa9B
         FTwBvxBjtAZXYJDD0O4xvK6EVYrppGXxjMb2d27D7rgdGjn+SThRbVIpX85eZO9g4Emv
         VQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705617161; x=1706221961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7Ga1PrZhviwyhWdstpoS5TcnXPX4KWerzR54KDAnLM=;
        b=OsdAlJL7yzMCDenm2KKzYJIisVkK+AdXis59G+dxlx3be4Jlc+OBP3BpsSMfCHB2JN
         xXHawLuoNlC68XvdN7X3sSi+2lphLsHAnHu6pm/qyMBwW46J3SVN6v+3kwXc8ULTiSrT
         JV5YanJRzbJEY2mrD+fveQDELevkSkLvDOXyPgi1N2IOzPGMGH5aNiSZlRQ60UEkKBie
         2DoRokFMyn+ByNFmFKnaV7a6138lnF83Zg3sQnfxhDsO6zehUV7UHGBdToGKvHItKfj7
         PWoyrVpoG5EN2uXIhPuu3N2QDnGmgZShg5TfgbY51wPVIcXu0BN3QvS8AsMeNZgEO/A/
         Utqg==
X-Gm-Message-State: AOJu0YzN9FybKPSSben+Q3qHy2aLpAtVAVR8jbm7RLY2y1i75ZyLRlad
	HR4avQ1OuLDt545Wa4/BzW3mszdQEC4r7inDwupcx+AYuOuZDmRh
X-Google-Smtp-Source: AGHT+IFe907cz1VECxYcn/G9MIGmipIjxpvLCX/m5AxErwGbsTdAngocchicXY9RPp5/igjgtPJt8Q==
X-Received: by 2002:a17:902:d485:b0:1d5:6a6f:6e71 with SMTP id c5-20020a170902d48500b001d56a6f6e71mr1526895plg.68.1705617161145;
        Thu, 18 Jan 2024 14:32:41 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f04f:73f4:b79:a70c])
        by smtp.gmail.com with ESMTPSA id mq3-20020a170902fd4300b001d5dad79fd6sm1865451plb.84.2024.01.18.14.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 14:32:40 -0800 (PST)
Date: Thu, 18 Jan 2024 14:32:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: aduggan@synaptics.com, cheiny@synaptics.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: synaptics-rmi4: Add a null pointer check to
 the rmi_driver_probe
Message-ID: <ZamnBjXaKDiqMSTR@google.com>
References: <20240117073124.143636-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117073124.143636-1-chentao@kylinos.cn>

Hi Kunwu,

On Wed, Jan 17, 2024 at 03:31:24PM +0800, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I did not suggest the patch, I merely provided feedback on it, so I
dropped this tag, reworded commit message slightly, and applied.

Thanks.

-- 
Dmitry

