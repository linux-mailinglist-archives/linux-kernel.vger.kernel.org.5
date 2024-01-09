Return-Path: <linux-kernel+bounces-21191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D7828B87
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CE5285FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529FC3BB31;
	Tue,  9 Jan 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONGmHqBf"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615F3C070
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7ba9f1cfe94so109386239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704822842; x=1705427642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvxQk9rfheLP9Xtji27sCGT3Sv4bNLZc44jbbgusrDU=;
        b=ONGmHqBfC1ejBCiK95L/gKcx3N81BvYLZ0b2EkYRCOJoWTJ9/Yhz4EdmUERPQWGhus
         FptUlXtgTzBIsA/xeUfVugvbhq8iALAGLmHftOKjPoYrJDeZbh4K1KTQg/vYQOJ+8yj9
         +dCc+ruL4a31Dh1J9oHMbkzlOMLlucY9szbPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822842; x=1705427642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvxQk9rfheLP9Xtji27sCGT3Sv4bNLZc44jbbgusrDU=;
        b=FzUFefpP+FsJL9JgXlwKklPAmkW8Hqw8bR4U/uiZO34wK7Ha0j8BcggSv7oNwq07f8
         VUUrqc9xYg0/dCoDBHYqJfWGYydFhLyReScCytu+I/ZSJEcNUj6MYvMgB/MoilqY9EGh
         iDAa01ijUKtp6X6H3RoaxFSBj9guRiqBgTh9M0fVcT/5efpr8+SNCQSDmqEaaLQe8Okx
         STFggd2U6IdQo66PpgVnst6A8CghrH7hVBoRwdOtJM274aId13XiitS3gtW36HVKbIzH
         ETOEyOczxfNIA9OaNdVusskEgG57sYkuvYHa9rhYu0UhoHgGdq0zfSPQ2n3VmJHhc2yD
         9PGA==
X-Gm-Message-State: AOJu0Ywk/YUIiHCi99dM+IHkZuX2Ww7RxDo0Rjj2nPU/7Vpsbeh5pmEY
	NSYt8cDlMkVulfh4cxb3Wqzqb5D/HawG
X-Google-Smtp-Source: AGHT+IETNvPU0pqR+rjwETC6lClyltQG+AAsL2rUrDmov8iCP0gjm6NfVC+6GYU4F02uh16JW6lf7g==
X-Received: by 2002:a5d:94ce:0:b0:7bc:2607:7caf with SMTP id y14-20020a5d94ce000000b007bc26077cafmr850204ior.21.1704822842469;
        Tue, 09 Jan 2024 09:54:02 -0800 (PST)
Received: from localhost (110.41.72.34.bc.googleusercontent.com. [34.72.41.110])
        by smtp.gmail.com with UTF8SMTPSA id e15-20020a6b500f000000b007bedb7d78b3sm441971iob.24.2024.01.09.09.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:54:02 -0800 (PST)
Date: Tue, 9 Jan 2024 17:54:01 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Doug Anderson <dianders@google.com>,
	Stephen Boyd <swboyd@google.com>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <ZZ2IOQEekFffJoHQ@google.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <ZZ15c1HUQIH2cY5o@google.com>
 <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>

On Tue, Jan 09, 2024 at 06:12:26PM +0100, Johan Hovold wrote:
> On Tue, Jan 09, 2024 at 04:50:59PM +0000, Matthias Kaehlcke wrote:
> 
> > On Wed, Dec 27, 2023 at 07:03:06PM +0100, Johan Hovold wrote:
> > > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> > > device address in MSB order when setting it using the
> > > EDL_WRITE_BD_ADDR_OPCODE command.
> > > 
> > > Presumably, this is the case for all non-ROME devices which all use the
> > > EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> > > use a different command and expect the address in LSB order).
> > > 
> > > Reverse the little-endian address before setting it to make sure that
> > > the address can be configured using tools like btmgmt or using the
> > > 'local-bd-address' devicetree property.
> > > 
> > > Note that this can potentially break systems with boot firmware which
> > > has started relying on the broken behaviour and is incorrectly passing
> > > the address via devicetree in MSB order.
> > 
> > We should not break existing devices. Their byte order for
> > 'local-bd-address' may not adhere to the 'spec', however in practice
> > it is the correct format for existing kernels.
> 
> That depends on in what way the current devices are broken.
> 
> Any machines that correctly specify their address in little-endian order
> in the devicetree would no longer be configured using the wrong address.
> So no problem there (except requiring users to re-pair their gadgets).
> 
> And tools like btgmt is broken on all of these Qualcomm machine in any
> case and would now start working as expected. So no problem there either
> (unless user space had adapted an inverted the addresses to btmgmt).
> 
> So the first question is whether there actually is any boot firmware out
> there which passes the BD_ADDR in reverse order?

Yes, (at least) the boot firmware for sc7180-trogdor devices.

hexdump -C /proc/device-tree/soc\@0/geniqup\@8c0000/serial\@88c000/bluetooth/local-bd-address
00000000  8c fd f0 40 15 dc

hciconfig
hci0:   Type: Primary  Bus: UART
        BD Address: 8C:FD:F0:40:15:DC  ACL MTU: 1024:8  SCO MTU: 240:8
        UP RUNNING 
        RX bytes:1700 acl:0 sco:0 events:95 errors:0
        TX bytes:128949 acl:0 sco:0 commands:578 errors:0

> > I suggest adding a quirk like 'local-bd-address-msb-quirk' or
> > 'qcom,local-bd-address-msb-quirk' to make sure existing devices keep
> > working properly.
> 
> I don't think that would work. If this is something that we really need
> to handle, then there's probably no way around introducing new
> compatible strings for boot firmware that isn't broken while maintaining
> the current broken behaviour with respect to 'local-bd-address' for some
> of the current ones.

I think it should work for sc7180-trogdor. For these devices the device tree
is bundled with the kernel image and can be updated. That might not be true
for other devices though.

Matthias

