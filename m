Return-Path: <linux-kernel+bounces-19977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3E8277C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44901F21244
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD115576A;
	Mon,  8 Jan 2024 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGeHtjsb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43F55778
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33674f60184so2315331f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704739013; x=1705343813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRT549Dt1i8lTKEeWMp/GaIWMDJ37dw966rXvED5F9g=;
        b=GGeHtjsbyNX/Htl9xUGGx6nbpbJI70r8VjQLG0WfK3vOGDOfwPij1rA2dDgtW+ALep
         reY6UYWfwBeH7soSnnwuNlNbnXY5HegNMDt17kwfkwnx11QgyFtcgheBw28cFuc7p1/v
         SX0JywBKE4TTVh7kXoDExXeYpbgJdS9m0fBT+aoIlY1pfoTOzS75d7JbWGoHe+pLGUK3
         FH4eqsNq92ecOApnUUPMeopIG/Mplo0SGBt1x0MSphhk+7G1P7NUMvy817rb562iM3kv
         0dbllYjY8iouWDm6mjLZmS0V8DwUV7Bki2dTgt3MvYZ0pTBG7MclaTZqV9/ocotzWKEP
         Gkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704739013; x=1705343813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRT549Dt1i8lTKEeWMp/GaIWMDJ37dw966rXvED5F9g=;
        b=qXmOqC2YrGGShOyhu5BUpz7PDoWze4C+JWhVnoSIs/EvSddtlvMY1YOl4aCaJIFVk7
         aH1WpBjkctm5sS244l9azPEc3muR6pjdXQpP4kmg13CnR/LTscA087+djZ4uxVRjZKFw
         nsF+bgyBOOQXg6WMI72l5zvvxvl6UeSzKhO+2tCzWBLJ4X3wvGhNn4ompxm7j3jKjxSe
         orP2fZoKP/YcfDrSfblmWLYAoza0BFYF1DUETL0QYlPg2VoJfPZx/zqtFDS+0yNk5LVn
         kQfbbjoYjnOdCavJEOLkqPRhfcvsNRuiJe8s3c5jGnNWasKHW26AyGPrKNIbpQ2EdkpM
         LpLA==
X-Gm-Message-State: AOJu0Yzrah2Ox/8QbWqmk3Qb6PmFK8/RoiOblWi8d8cxNbCLRu9sZqPK
	P21W3DSGZRfrVdjoeSUzi9m7PitvJSyPAg==
X-Google-Smtp-Source: AGHT+IEKJgWchI7ueCFEQHuXfSlp4/f6sZeDJMFzzGDxG4kG0BxK59hylQ0NUteD+2FGE+dAdWSKfg==
X-Received: by 2002:adf:fc03:0:b0:336:6797:485c with SMTP id i3-20020adffc03000000b003366797485cmr2027448wrr.27.1704739013536;
        Mon, 08 Jan 2024 10:36:53 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d55c5000000b00336e15fbc85sm306169wrw.82.2024.01.08.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:36:53 -0800 (PST)
Date: Mon, 8 Jan 2024 21:36:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-hardening@vger.kernel.org, keescook@chromium.org,
	error27@gmail.com, gustavoars@kernel.org,
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Message-ID: <8023e9f4-c14b-453a-8071-ef94bba0d0d3@moroto.mountain>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <fc132bde-d42d-4aac-ba91-7a939a18091a@moroto.mountain>
 <7826922a-d642-424e-bede-bfc45be9254d@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7826922a-d642-424e-bede-bfc45be9254d@embeddedor.com>

On Mon, Jan 08, 2024 at 11:03:51AM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 1/8/24 01:33, Dan Carpenter wrote:
> > On Fri, Jan 05, 2024 at 08:40:00AM -0800, Harshit Mogalapalli wrote:
> > > Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
> > > 
> > > memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
> > > at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
> > > 
> > > WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
> > > dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
> > > 
> > > Some code commentry, based on my understanding:
> > > 
> > > 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
> > > /// This is 24 + payload_size
> > > 
> > > memcpy(&dg_info->msg, dg, dg_size);
> > > 	Destination = dg_info->msg ---> this is a 24 byte
> > > 					structure(struct vmci_datagram)
> > > 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
> > > 	Size = dg_size = 24 + payload_size
> > > 
> > > {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
> > > 
> > >   35 struct delayed_datagram_info {
> > >   36         struct datagram_entry *entry;
> > >   37         struct work_struct work;
> > >   38         bool in_dg_host_queue;
> > >   39         /* msg and msg_payload must be together. */
> > >   40         struct vmci_datagram msg;
> > >   41         u8 msg_payload[];
> > >   42 };
> > > 
> > > So those extra bytes of payload are copied into msg_payload[], a run time
> > > warning is seen while fuzzing with Syzkaller.
> > > 
> > > One possible way to fix the warning is to split the memcpy() into
> > > two parts -- one -- direct assignment of msg and second taking care of payload.
> > > 
> > > Gustavo quoted:
> > > "Under FORTIFY_SOURCE we should not copy data across multiple members
> > > in a structure."
> > > 
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
> > > Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > ---
> > > This patch is only tested with the C reproducer, not any testing
> > > specific to driver is done.
> > > 
> > > v1->v2: ( Suggestions from Gustavo )
> > >          1. Change the commit message false positive --> legitimate
> > >             warning.
> > 
> > The commit message is fine.
> > 
> > Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > But, I mean, it's not really "legitimate".  It meets the fortify source
> > heuristic, but it's still a false positive.  Fortify source is
> > *supposed* to find memory corruption bugs and this is not a memory
> > corruption bug.  It's just that these days we have to treat foritify
> > false positives as crashing bugs because people enable it and we have to
> > fix it.
> > 
> > Let's not pretend that fortify has helped us in this situation, it has
> > caused us a problem.  It has taken valid code and created a crashing
> > bug.  I'm not saying that the cost isn't worth it, but let's not pretend.
> > 
> 
> It's a "legitimate warning" (which differs from a "legitimate memory
> corruption bug") in the sense that the feature is doing what it's
> supposed to do: reporting a write beyond the boundaries of a field/member
> in a structure.
> 
> Is that simple.  I don't see the "pretense" here.
> 
> BTW, is this _warning_ really causing a crash?

I don't know how many people have Reboot on Warn enabled but I've heard
it's a shocking high number of people.

My problem with "legitimate" is that it's a biased word which imples
"good".  A more neutral way to describe it would be "acceptable" or
"matches the heuristic".

Generally, we get a lot of patches which are to make a tool happy and
sometimes like here it's probably an acceptable cost.  But I think
other times people lose sight of what it's all about and confuse good
and bad.  In some kind of very literal and narrow sense this warning is
bad.  It takes perfectly okay code and turns it into a crashing bug.  In
the larger sense and long term view then, sure, the heuristic is useful,
but right here, in this situation, it's bad.

regards,
dan carpenter

