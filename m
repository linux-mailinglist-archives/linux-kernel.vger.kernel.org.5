Return-Path: <linux-kernel+bounces-19440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB2826CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5807CB20FB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC8314AAE;
	Mon,  8 Jan 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OxhB4BQY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594C29419
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55590da560dso1912144a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704713715; x=1705318515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OXz+M+W1v8IkWUzljPV7N45CqW1f60s7WitH1y4Yico=;
        b=OxhB4BQYv3lV+OUtH0s0S3+kx9PplGOduerl4MXTZ3DtLcBDVPWZrfK5SDWffXXoAW
         Tg9jlxyjVOUknFEd2OxfYA7aYh9zudkg4/Mqq0m2ZCBKZghDhX7DYlnMoUx2M6T8AB4f
         mNclig/NaQtLk/vcjgQ0gLcQHH5x1KSxrrKEqkSYd2LCxWK6SecnwKXSg+VCnRecfGa9
         EFZZDtHpBbzFBV8FT+gPIyZHV/z7MKxgOOit7UwZiFkPX23x8ijr/9DL+dx134t6sklS
         CEPjJWmcIGbyhZs4BcpJGEVy+GxJ564BzGR8HGdeWGhEqgYPOB/fhyRRc35Fodp+owap
         9jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704713715; x=1705318515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXz+M+W1v8IkWUzljPV7N45CqW1f60s7WitH1y4Yico=;
        b=Q2kfh/qlveb+P3dlsNR+IS2bnmfZS1WI9F+X5xzzEokUq/ANvpA0/2lwPRjsbOIlZV
         n5GT6pr9z9Lg/6lPOULjbMhQpkoHCoKftahZF7KWgt80RZlNzMZw5CU6GknsiGDTFP19
         NUh8mYE2kOlFX0lota4z8aH181ipd73Dqp/y0mfpzL54FeTq0ZPMTAloyvam7NRpgSob
         BZn3P51xg9GExyKoXqRxq9D90QdWCE0Ff7LGq/k/se5a8zXDjWthiKp1AUo6hzdcDek3
         2mvvDWTwLbgAKQURRoEyoasDuLTjEjt1X6FoMGqkarvZoNExoAmgh1w1ami8BY61BMVk
         7EAw==
X-Gm-Message-State: AOJu0YxutY3/dOslgKrqK5/pNwkZlC91V0iB1fp3UCYkvOP9ry9HB4aB
	0X/4l2HCBS2c3N4R5ITsmkHaR9X65bJsBA==
X-Google-Smtp-Source: AGHT+IGNFTf74SYqecew/zugquC+nKHg3U1rGduBdRyqSi2v04Wt1HCZM1c+hLYUJf5m9uXkjPyhsA==
X-Received: by 2002:a05:6402:b03:b0:557:427c:1c2c with SMTP id bm3-20020a0564020b0300b00557427c1c2cmr1797243edb.85.1704713715404;
        Mon, 08 Jan 2024 03:35:15 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ij15-20020a056402158f00b0055410f0d709sm4143181edb.19.2024.01.08.03.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:35:14 -0800 (PST)
Date: Mon, 8 Jan 2024 12:35:13 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph =?utf-8?Q?M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
	Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, linux-kernel@vger.kernel.org, David.Laight@aculab.com, 
	Conor Dooley <conor@kernel.org>
Subject: Re: Re: [PATCH v3 0/2] Add Zawrs support and use it for spinlocks
Message-ID: <20240108-a56ba0dfd1779e4ab6893d16@orel>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
 <ZTE7eUyrb8+J+ORB@andrea>
 <CAEg0e7jkTOn1pjO=+GaiCZJ9_Yd2NcB1GMG=Q6m3-r0+Q0OjGQ@mail.gmail.com>
 <ZTJUOji+B+dDbMKh@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTJUOji+B+dDbMKh@andrea>

On Fri, Oct 20, 2023 at 12:19:38PM +0200, Andrea Parri wrote:
> (Removing Heiko's @vrull address from Cc:, since it seemed to bounce, keeping
>  his @sntech address.)
> 
> > I had a quick look at your changes, and they look good to me.
> 
> Great.  Thank you for looking them over.
> 
> > Did you agree with Palmer about testing requirements?
> > I.e., do we need to run this on hardware that implements Zawrs in a
> > non-trivial way?
> 
> I didn't quite discuss such specific requirements or hardware implementations,
> but I agree that's a valid concern.  Not that I currently have access to such
> hardware; any further inputs/data will be appreciated.
> 
> > I can try to raise the priority on this here, but can't promise anything.
> > For me it is also ok if you take over this patchset.
> 
> Thanks.  Either way works for me.  No urgency from my side.  I'd say - let us
> leave this up to the community/other reviewers.  (IIUC, Palmer was recovering
> from a certain flu and might need more time than usual to get back here.)
>

Hi everyone,

I'm also interested in seeing this series resurrected and making progress
again. I'd be happy to help out in any way. It's not clear to me if it has
a current owner. If not, then I could start shepherding the patches with
their authorships intact.

I may be able to do some testing on an FPGA too.

Thanks,
drew

