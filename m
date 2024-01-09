Return-Path: <linux-kernel+bounces-20216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD0A827C11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441061C21C89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E7F186C;
	Tue,  9 Jan 2024 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCeq9nn2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AEF15A4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704760208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5k+ZXtVfG6u9Bw3T1Sa5a4COKTCSddmRJFEwTBvDNI=;
	b=gCeq9nn2aypv0+VE1dkvzIjoyW+kVcGqmRmafiJ1fKWyuuiH4SQkWNR1x8zVErR8IL36TG
	+7enhepNDCYWH1vkhTWpmsPhfyEko07b0xdben0UPazp/nZvipsMJ2R+RSnM7XpdiUUd/f
	9p3izZsqddWeHQ54MEqgqj0fqUZdiAk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-TZo_lc2OMdyQEgTl41qMjA-1; Mon, 08 Jan 2024 19:30:07 -0500
X-MC-Unique: TZo_lc2OMdyQEgTl41qMjA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d44c745bfcso26029175ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 16:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704760206; x=1705365006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5k+ZXtVfG6u9Bw3T1Sa5a4COKTCSddmRJFEwTBvDNI=;
        b=jXMzxcRsMrIGGzXtkhpGQNj1SRAKaM5WB+hIw5vWeSb0ARmL/ADnNdJnnpKsAhdtgT
         wsy3+ntVESN4ErV0rpCgrm7nFexBvB+NjopKIW5s6pxLAVJo0ZA4KcBdI5ovaAwKOwWx
         bJUCwOdiBpJNssHi3Wc6j9AtsnaLr04fz2R0xQAAw59usjuBgCOk6HjVj2XZAii47N3M
         VZNvGvoJaQtyTIuqUttB0YguSnTZDn4YflPQYPz8fgWBPmlz6bHfFXmTvaoKClYA9gCu
         akjBo9kPFBMIQHmSe0Y64ycxpmReIre1mAYJO+zP9NezoRm1RHpiyTC9bLAZKD+9z7bX
         EXuA==
X-Gm-Message-State: AOJu0Yyz8pNM0EOI6wEmZ55Dx6tHWcbn2G6I2bM2CyTo9aiEZOjwfXUt
	PXEfx2Am/MEXY6DPpP251EuX4Goz+dj5ldONQpHQ84uijnrOTWOs8YIfkmpUs7p6zZWn0A/4Zu+
	mPUrv2gihBUZ1eogunRmfJPsvfqMi7QSb
X-Received: by 2002:a17:903:2344:b0:1d5:4c37:714f with SMTP id c4-20020a170903234400b001d54c37714fmr1278400plh.22.1704760206412;
        Mon, 08 Jan 2024 16:30:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKsw+pTaiH9xGzdzNmrW8Ru6E0RFiaaS1q6loEdAq46i2p3vx+rT4qLXe66Af5VWUPuJT01A==
X-Received: by 2002:a17:903:2344:b0:1d5:4c37:714f with SMTP id c4-20020a170903234400b001d54c37714fmr1278384plh.22.1704760206123;
        Mon, 08 Jan 2024 16:30:06 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jf18-20020a170903269200b001d4abb685c7sm477815plb.22.2024.01.08.16.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 16:30:05 -0800 (PST)
Date: Tue, 9 Jan 2024 08:27:06 +0800
From: Coiby Xu <coxu@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
Message-ID: <hnx4cg626xworbjszwn2m7cijhh6fux7h7qnatgccfym6mjxic@uzs7ufqoswhw>
References: <20231227044156.166009-1-coxu@redhat.com>
 <CY54Q6U6UMKM.2H5N3BACDBGU0@suppilovahvero>
 <43dozoqfip7m6nglbwzwyzykx23fpzbp7d42pcqzudnzlfvfkb@yjvuo5a6suvv>
 <CY6WDWW69XDP.2E8GFRMXYTB22@suppilovahvero>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CY6WDWW69XDP.2E8GFRMXYTB22@suppilovahvero>

On Fri, Jan 05, 2024 at 06:02:38PM +0200, Jarkko Sakkinen wrote:
>On Fri Jan 5, 2024 at 3:20 PM EET, Coiby Xu wrote:
>> On Wed, Jan 03, 2024 at 04:09:29PM +0200, Jarkko Sakkinen wrote:
>> >On Wed Dec 27, 2023 at 6:41 AM EET, Coiby Xu wrote:
>> >> Currently when the kernel fails to add a cert to the .machine keyring,
>> >> it will throw an error immediately in the function integrity_add_key.
>> >>
>> >> Since the kernel will try adding to the .platform keyring next or throw
>> >> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>> >> so there is no need to throw an error immediately in integrity_add_key.
>> >>
>> >> Reported-by: itrymybest80@protonmail.com
>> >
>> >Missing "Firstname Lastname".
>>
>> Thanks for raising this concern! I've asked the reporter if he/she can
>> share his/her name.
>
>Also, it is lacking fixes tag.

Thanks for catching this issue! I've included the Fixes tag in v2.

>
>Fixes tag is mandatory, name part would be super nice to have :-) Since
>this categories as a bug fix, getting them in is 1st priority and that
>thus does not absolutely block applying the change. Thanks for going
>trouble trying to query it, however.

Thanks for the explanation! As I still get no reply from the reporter,
so I guess we have to accept the name part for now.

>
>BR, Jarkko
>

-- 
Best regards,
Coiby


