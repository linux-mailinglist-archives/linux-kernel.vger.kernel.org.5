Return-Path: <linux-kernel+bounces-57552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2834F84DAA3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55651F22BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C92369318;
	Thu,  8 Feb 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEjNFd91"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C06930C;
	Thu,  8 Feb 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707376884; cv=none; b=dxi2mNQAB/3lLOEcYzC+q0g/7bO9jFgvh8E7tF/aNJfaqXvEp27CFWOAgaXiHctP4smv2nRjODekJhQHONmhawZcHyOdfDujqlj7ctH/+Ona6qRLZq9nLDycVCTfI4pdWt1myZuDnf8hFXR5Br3k/1xJTk2kAAgV7jqO9x/SuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707376884; c=relaxed/simple;
	bh=abortNf4F3xd5B2QzyOXfbayOhs3Yeycsl9F0Lngd0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW5XmiY2OSulkTIISPCXC7YFD7Vq/sJdhLFZdUCQwpKpv5/1kBk4JYnkKEHKmQ5m2U+OMFRmS/AGi67dGZov+DEmPfOwz6hPUeQECy0bHUBu39iY2eztYY2fMeFDCbJWBo+qgmXdnGGM8RrvNsSjxltmPtScUSBH5TD8tf2Lbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEjNFd91; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a99f34cc8so7843121cf.2;
        Wed, 07 Feb 2024 23:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707376882; x=1707981682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=abortNf4F3xd5B2QzyOXfbayOhs3Yeycsl9F0Lngd0c=;
        b=FEjNFd9158EUnk4PhyzxKVCpbTmYIvhITPtr8AHMo85PYd40q1uK4WDPPWvpTVA68E
         8ylHJFJaUdzv87Cnh9ODdJwG+qqrBmsVbjdVjh9FcS5+0cX0cT/T/loqC2otdffaeWTZ
         zLLmrpm4Ev9HHMu5hGS/ejy6cN8jt5kR5j7C84OCPT1ZD3mnHo9tQbh50nvbN1m17tOH
         +xo9q3JVkaDD1FwTsA9tJFVvfNoasn5ZX6dS0TUHs9UU/XpHCyQHIRQUFXl9PRq1k4kc
         PT9QIvPzdl5V6QRwiQnXhs4n1coKQwzK+cAV/jwO0QheDnsijDn6HWHxr1BhFdHtnR5P
         Rgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707376882; x=1707981682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abortNf4F3xd5B2QzyOXfbayOhs3Yeycsl9F0Lngd0c=;
        b=dNJWDuAw8zKZAdDd/H9Q8siXCcKYUM3MlIKmGJsLF75prgLDipyFDPO2syV6XSmgbF
         yoRWbQAFC8GXTbkl2eceGdMt1aJR7YCLdN3WMmT3/PcktpEQj04beLWdwe8JxBwIgh+f
         xBbFPCEervnPKHnvocNedSMfJpPvrzML1krwsQBG/GQRtIKsEgxPTR124NVpSzbpYcg2
         mu0VAGoDfJUGg8JN/gJF0k9zUcMkG4ECnhH53D5h1eUxUvlvtvrSApTZDmSgeQClVeiL
         3wypBiFLHCsTnWbrNwRR4T6HH0+swH27cKJ/J3uJh059MDLFlLGqyEYD0ZL9eS9IiovE
         ad2g==
X-Gm-Message-State: AOJu0YxvSHFIrEYYMI/ULla1fZf5b/tHv42WB2nc6l2zmWl+xVBrjvnI
	n/Lc6CgZsVwB/lVVLbpxUdod7QGy3h6Qii1Rpvp/ryYqgmZv9/wdm9QYZDmIspeg90xSM3htVsx
	SUqQnqN8JnxBbUK2HLbCQ5kn+TDk=
X-Google-Smtp-Source: AGHT+IG/dHbgLMwymyaUYOT3MZX6hYS4HF/nmLMQj1CdjRkTZhSRkMV+xF05I21XpkpWk1HEmgoR9KcY4D3hqK/8qv4=
X-Received: by 2002:a05:622a:5094:b0:42a:8a40:e33c with SMTP id
 fp20-20020a05622a509400b0042a8a40e33cmr7494698qtb.57.1707376882011; Wed, 07
 Feb 2024 23:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj> <31d9b48d-320b-44b6-9ab5-d53f741dcc72@redhat.com>
In-Reply-To: <31d9b48d-320b-44b6-9ab5-d53f741dcc72@redhat.com>
From: Andrey Melnikov <temnota.am@gmail.com>
Date: Thu, 8 Feb 2024 10:21:11 +0300
Message-ID: <CA+PODjozWG6iXcR01KE4N1DyTKeKXtravwanWS3Gtq8mEqutuA@mail.gmail.com>
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Hi Andrey
>
> On 2/7/24 10:58, Andrey Jr. Melnikov wrote:
> > The ASM1064 SATA host controller always reports wrongly,
> > that it has 24 ports. But in reality, it only has four ports.
> >
> > before:
> > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> > ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> >
> > after:
> > ahci 0000:04:00.0: ASM1064 has only four ports
> > ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
>
> This still says 24 ports, is that a copy & paste error in the commit msg ?

This is the raw value of the read-only Host Capability register, how
should it be changed here? If silicon lies about its configuration -
kerel prints what it sees from silicon.

