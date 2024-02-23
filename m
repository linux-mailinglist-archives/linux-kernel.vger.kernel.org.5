Return-Path: <linux-kernel+bounces-78371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D986129D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3BC28271E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808287EEE6;
	Fri, 23 Feb 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3M2njpe"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA686FBF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694736; cv=none; b=LdNOTq3oFhIRZWyJ6mgGaQq8U65ZFghcmN4AeOfl+ZetnQ1IpcgB91MWefxI6PuQB+kX6WleaUHa9RVPBRyjMb/3TbjfQ2Ahx/xMOAaKF2uj3QFZVK7jbjjYa3yr2NBFdvqEY21Mhu04ns11PWkXErG2g/BYq2DQ7xYQj2Rg2pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694736; c=relaxed/simple;
	bh=8W2YjE8PwlPeNRufHAAQFYoxCLTiN7XteQ72PTA9h8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2e44bV6uroJ7IA+Xz3sB+Mxu5GK4zSCtWVdECA2b+zPhrjXtef9h7DsANeKLeEIBUsrye+WWNmxMxtcFHvMfY1+RY8Hrn0ejb+6HGgtV1c+dmHX8beQs/LPKcpKfgZtffTxM1J9DNYSQxvru6ulPOI3EP9efk16JERFiIb7Qzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3M2njpe; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e4f4e463so1188473e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708694732; x=1709299532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=19cp42f8tFvnJXMehM3M7grgDYIRgHH0G4ve9idhWWk=;
        b=o3M2njpeL/tuzIO1oFzZzMJCpD6Hdk2fJVFhpyePe0qsHq3kgJNe3b8Nb1dbrDiGnE
         OzTj67DixlT4sA+hBBy5btC/RA0+SdwksT7ls/pI25X6fBIyRwk76XJLV39RuceE9BIf
         AM4YcfdCCELHtcMk24265lwTnhZcmWGKB1MP/AnmM3zbm5cByVZUYSOOIX6k9GuDrfjn
         766Zd/CjS6XvNchU30aIn6vHso/WgDiM7FvfZzLVqppwVyMkjrC9ROJvIueSFlkqfSEx
         1KUGLksiucro09yn8O+qzqZv8Arv7ivZyBLmSdNOp+SD8nj4Li61BNgdkVlBy9FkBWaw
         oX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694732; x=1709299532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19cp42f8tFvnJXMehM3M7grgDYIRgHH0G4ve9idhWWk=;
        b=YHstZXBwePtRSZWP6SzyU2XuIDFkFjPPZkFbATs40RhGhRVyXQeExncmMdywOefU5e
         gruSOVzcCWL987ospygQkKRUS93ZXEhsT6G0FwtBrMP4Ut5SXoC0gDvzXXug0WbdUpVn
         TNa2CV6lGQTjgRAwrXSaX2cclzpDMQoOYxPyrq1OVpKfYSgaG5BCqQop2QyS6WZZ9eWA
         3hC5vGB95rQlSA99rY/Y4GyUxcqC/wtKItncANb9J9Gd6Ut1pvLmOT+5Te9kEvfJGluG
         4kxyBXvb/e+lSXMYV48lDq7xekPhEtlo5+RS7RmWwklaC77XRM41NbuNppv2Gm2GLPIl
         BolA==
X-Forwarded-Encrypted: i=1; AJvYcCXzzikq9bpc5tnWQpkk6dpnicGjeDi4aafQOvW+jMX65N78BOraRZihc+VKmG6YrvVZXh1W+jNi7ZHKXxSg29yha6maem3nR8dab5GT
X-Gm-Message-State: AOJu0YwlOjfcvBQ0F6qS8vjch267/MNYGNox/mMZTFOpiIHVxXRohtJP
	aLtfHg+a3+FpKit3pJESdTMhLclq8UV9s9XXkX971AmDeBMp+Tjds1KaezWeNxWPw6GmFchSodV
	u7zFed3Rw3if0EPlrU7gl8tWIxPVl5mrqYIutN0NE8TI5kBenQlY=
X-Google-Smtp-Source: AGHT+IGAR/bF+42kR+hM0mMtSuGMWvJoLo2qwVPBAxda+Xy6v3FF+h6fREGI2CjWkB52iKh+m7RhPE5UXlpnJKKzfz8=
X-Received: by 2002:ac2:5d48:0:b0:512:df5b:ee91 with SMTP id
 w8-20020ac25d48000000b00512df5bee91mr1425719lfd.30.1708694732339; Fri, 23 Feb
 2024 05:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAC_iWjJ_TS66KG7uGOQFiKGfZNKjnod6u7zua4LVK-EJHEUv8w@mail.gmail.com> <7feb889f-f78e-4caa-a2f4-9d41acf6ca76@linux.intel.com>
In-Reply-To: <7feb889f-f78e-4caa-a2f4-9d41acf6ca76@linux.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Feb 2024 15:24:56 +0200
Message-ID: <CAC_iWj+9eWesWD62krdhLwj58fpjptpnnG5JpUJUpFsg7_GzOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: Add get_event_log() support for CC platforms
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Apologies for the late reply,


On Mon, 19 Feb 2024 at 09:34, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Ilias,
>
> On 2/18/24 11:03 PM, Ilias Apalodimas wrote:
> > On Thu, 15 Feb 2024 at 05:02, Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >> To allow event log info access after boot, EFI boot stub extracts
> >> the event log information and installs it in an EFI configuration
> >> table. Currently, EFI boot stub only supports installation of event
> >> log only for TPM 1.2 and TPM 2.0 protocols. Extend the same support
> >> for CC protocol. Since CC platform also uses TCG2 format, reuse TPM2
> >> support code as much as possible.
> >>
> >> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > [...]
> >
> >> +void efi_retrieve_eventlog(void)
> >> +{
> >> +       efi_physical_addr_t log_location = 0, log_last_entry = 0;
> >> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
> >> +       efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
> >> +       int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> >> +       efi_tcg2_protocol_t *tpm2 = NULL;
> >> +       efi_cc_protocol_t *cc = NULL;
> >> +       efi_bool_t truncated;
> >> +       efi_status_t status;
> >> +
> >> +       status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
> >> +       if (status == EFI_SUCCESS) {
> >> +               status = efi_call_proto(tpm2, get_event_log, version, &log_location,
> >> +                                       &log_last_entry, &truncated);
> >> +
> >> +               if (status != EFI_SUCCESS || !log_location) {
> >> +                       version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> >> +                       status = efi_call_proto(tpm2, get_event_log, version,
> >> +                                               &log_location, &log_last_entry,
> >> +                                               &truncated);
> >> +                       if (status != EFI_SUCCESS || !log_location)
> >> +                               return;
> >> +               }
> >> +
> >> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> >> +                                          truncated);
> >> +               return;
> >> +       }
> >> +
> >> +       status = efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
> >> +       if (status == EFI_SUCCESS) {
> >> +               version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
> >> +               status = efi_call_proto(cc, get_event_log, version, &log_location,
> >> +                                       &log_last_entry, &truncated);
> >> +               if (status != EFI_SUCCESS || !log_location)
> >> +                       return;
> >> +
> >> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> >> +                                          truncated);
> >> +               return;
> >> +       }
> >> +}
> > [...]
> >
> > I haven't looked into CC measurements much, but do we always want to
> > prioritize the tcg2 protocol? IOW if you have firmware that implements
> > both, shouldn't we prefer the CC protocol for VMs?
>
> According the UEFI specification, sec "Conidential computing", if a firmware implements
> the TPM, then it should be used and CC interfaces should not be published. So I think
> we should check for TPM first, if it does not exist then try for CC.

Ok thanks, that makes sense. That document also says the services
should be implemented on a virtual firmware.
I am unsure at the moment though if it's worth checking that and
reporting an error otherwise. Thoughts?

Thanks
/Ilias
>
> https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#confidential-computing
>
> > Thanks
> > /Ilias
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

