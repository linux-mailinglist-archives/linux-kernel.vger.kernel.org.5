Return-Path: <linux-kernel+bounces-140572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8978A1654
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65007B2593E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4B514D6E9;
	Thu, 11 Apr 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr4SS0sD"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81114D432
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843616; cv=none; b=Up38wn9GJqJ9fDG5R7T9drXIQOvjiEypKKwQm4rE1h8esHxd/05rWWQ0mRA/yKz5DwGEDgQ6CC2ODG/nFud09LZW05crAjk6srq2jrqCjPWbFsGh4++N0Jcvym3jpYCXWH0BnvOilgHU+prNbKK/YreEot/mPP0zeAM87qsa9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843616; c=relaxed/simple;
	bh=EY8m+g9CMZtegLlR/T97QLoufTL2+pUIcZaZY4IJ7r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4wGNCur3Erzg/4WwLsduOovu0ufwL0Se911rqZwar8QIXNJ4IADUKtpQ8I2dIUONdZVSUDPMoflaV9sniI/heIRqvst4dtg3+S8tb1U1JIgJHI1RHm4L/kGVlWFHyyuHXelVZcapnRkkqDtWNTDBcrF5ZZrhOyZc83sIg9hOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr4SS0sD; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a51b008b3aeso668827966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712843614; x=1713448414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EY8m+g9CMZtegLlR/T97QLoufTL2+pUIcZaZY4IJ7r8=;
        b=Rr4SS0sD7q+iI1PFSPq9HlhL7nkdcFZzUPs5g7JGiVoxlm+HWZgGdH7AuTxOQ8QqvJ
         HAyO1uuUUpyhSBcu/K/TpCB1CfSX97sYIQ7DGoV5cgB+cCoagJsBSe5fpS1Bkpcyta2d
         amYb93EAsQ4kJsGsJUsbSe9FQo8d+9Xl2P0Q+NHBDBt8CO6JDs1hVI1uMsGho22RsFlf
         i2A4A406MaQ3McGNnelAy9o85j2UcMK/Qtp2LUc0RhjkN4eFIDtlGPCsRuH5KMbLWXnu
         yE8TuopOZIoUUVZjrpHHyl0PfOZqST4/iRKlx28Spdxzs/XWbG5ihdypOdo0LSozxnsW
         2Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712843614; x=1713448414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EY8m+g9CMZtegLlR/T97QLoufTL2+pUIcZaZY4IJ7r8=;
        b=trgaKyeD5X0PSeFCz37TpX5VrI3oG4FjPt7XnEnaWADU0376HRBUB21tUGRyg5p97r
         Q+DG1WKbyyML27sx1CN/ZEbP7gNGCp7HkQ0FLmrrvUyRh9glHAneqrrSTyiBb/bPgMZP
         14iXBK27DCCwIQN2t8J9K7axgkUSFGiyEvBTpxV2WMOd239+VsUZ3U+rqpi0mMl7Jj5b
         reK90PeqbLWqDaKjJ+P6I5YJJITBbYGy8lVX2HFW3+j/+GNHG2VFx5fuJim3AFVxDzME
         ToVHv1njFEqO/8QREVUL7VdpxLZMVhGLh7JP8LCCmJ0n12DzssBO6MyLXB7lsCZ1R/2n
         Z3bg==
X-Forwarded-Encrypted: i=1; AJvYcCWi51UgjEJh7OAZ/C9w8PHqflf76no3rSOepjsxAhf6NBN9l2vpFQmOfoDpsoZo//mgPUXclcPwSUiPZUeeJyANsQ3/BDaeLIuGTUZI
X-Gm-Message-State: AOJu0YwHuO+nTj4FlP3Yed7FO8e9HUIyyC9mvyD46kyKkwG1FqOElhZT
	lrCBlVZSlSn6uN0dOrxjtAvHKkhCdEBrgCG0vUe8De+SYJuoOI4Uec1SQP59D/1i1lj0YFF94ul
	6I7wnMHr5AjumlD8lmcowfWSi5gc=
X-Google-Smtp-Source: AGHT+IEaJtbXNe783ES9ML/oQb6Rb3vFpJu6FcHuSpkM5YYYXWSE29rRkQiDW558mslsXdf6lGbIAGzAlriBXwYP1WY=
X-Received: by 2002:a17:906:3088:b0:a46:cef3:4aba with SMTP id
 8-20020a170906308800b00a46cef34abamr3573568ejv.75.1712843613689; Thu, 11 Apr
 2024 06:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407132054.12170-1-qq810974084@gmail.com> <2024041153-undrilled-partition-2a9e@gregkh>
In-Reply-To: <2024041153-undrilled-partition-2a9e@gregkh>
From: Huai-Yuan Liu <qq810974084@gmail.com>
Date: Thu, 11 Apr 2024 21:52:57 +0800
Message-ID: <CAH9++vFsOUADuQ5Rnx1Kv-Q7Y54pZMh_Ou46OPp9xZ2va6EpBQ@mail.gmail.com>
Subject: Re: [PATCH V3] ppdev: Add an error check in register_device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, arnd@arndb.de, linux-kernel@vger.kernel.org, 
	baijiaju1990@outlook.com
Content-Type: text/plain; charset="UTF-8"

Hello,

I offer my sincere apologies if my submission has brought you any
dissatisfaction. Could you please kindly inform me about the reasons
why this patch could not be accepted? Your reply would be greatly
appreciated.

Best regards,

Liu.

