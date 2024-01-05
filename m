Return-Path: <linux-kernel+bounces-17878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5284C82547A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792E61C22770
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B12DF65;
	Fri,  5 Jan 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Os2GnA0D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E52D7A6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704461423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZyA0UiJjlDprNRBcnFya4w1YVvVVz2SWLbH1aem4wE=;
	b=Os2GnA0DC0ws1Y0eDfmVgJrTGC5oPeETsWmu1UpnCmah8UlTTjzzHilPThVOktUIdWfLKY
	tJNP2CswsUI9w0SPOdFsGwdDPJ+bulJo07qYHfkt597gbpaQwlq+Iro976zKOxxwLVWxck
	BWTmwPJEa2j6lf8WAYSY+8iSfUk9gJc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-qLFpCxujO7-CHpgI8wXWag-1; Fri, 05 Jan 2024 08:30:21 -0500
X-MC-Unique: qLFpCxujO7-CHpgI8wXWag-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-596194636d4so1606598eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 05:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704461421; x=1705066221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZyA0UiJjlDprNRBcnFya4w1YVvVVz2SWLbH1aem4wE=;
        b=OraDj6gsC+bVFIl6RhdK8SSHfrv3UUH17H96pcfMuDCIw544c/U5fwhYZd9/f4P+e5
         kbm51RP2efmvvCVUxOJV4fCdqi/zCeppLT62cNRYPr9L8DHecEjmzp6z/1INCNkg6quQ
         N5jzcFl+BofJ/tYDTYWXHGxNZkrOi+lHYxlC863OW8C6R0md783BRxCTRlMxh2CFCHtq
         REenqHSdPt4Bc6uTotNQWgemUzDyqyRXn+sZBTxaUPI4L+0mcj1/pJxXaShMf9Wk5sfe
         cNbvAjG2gt/WSwINT2z46HSLBUkw0gQyn7zbwRYsG4JMEex5SyrAcbf2pbGr5E1su/nv
         n1ZA==
X-Gm-Message-State: AOJu0YwshS5nqRLlskZShQg1m1iWZnU9X/n8frp+Rrlj8g1Jayvqf9Xm
	uZvakP+EZHHcrU488FCHiPZbyA84Y5H1hrSMplxlHeXzN1KGAqzVb2M0UPs52l6/itWr1AMHV9U
	KWX2rM+Uz3Izwq23p2xB6es+VS1lOk4nk
X-Received: by 2002:a05:6359:309a:b0:172:fe9a:44d9 with SMTP id rg26-20020a056359309a00b00172fe9a44d9mr1557961rwb.33.1704461420862;
        Fri, 05 Jan 2024 05:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHOshhGoPVy2RT2ywK6Ed2waSP6I+rGR3wAj2kBv8fMfQgXPaSMZNLO9B9u77ckjUZGIzI7w==
X-Received: by 2002:a05:6359:309a:b0:172:fe9a:44d9 with SMTP id rg26-20020a056359309a00b00172fe9a44d9mr1557952rwb.33.1704461420523;
        Fri, 05 Jan 2024 05:30:20 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j3-20020a63fc03000000b005ce71f1440bsm1402487pgi.72.2024.01.05.05.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:30:20 -0800 (PST)
Date: Fri, 5 Jan 2024 21:27:28 +0800
From: Coiby Xu <coxu@redhat.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"itrymybest80@protonmail.com" <itrymybest80@protonmail.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
Message-ID: <jaybj2ra7cjsfazxcumpkaozthl245a6s4sdmjsrmvpuddb5ye@cntxrwommw4z>
References: <20231227044156.166009-1-coxu@redhat.com>
 <2E548AE0-8029-4BB0-B162-4CAD0544EDB8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2E548AE0-8029-4BB0-B162-4CAD0544EDB8@oracle.com>

On Tue, Jan 02, 2024 at 05:33:53PM +0000, Eric Snowberg wrote:
>
>
>> On Dec 26, 2023, at 9:41 PM, Coiby Xu <coxu@redhat.com> wrote:
>>
>> Currently when the kernel fails to add a cert to the .machine keyring,
>> it will throw an error immediately in the function integrity_add_key.
>>
>> Since the kernel will try adding to the .platform keyring next or throw
>> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>> so there is no need to throw an error immediately in integrity_add_key.
>>
>> Reported-by: itrymybest80@protonmail.com
>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>

Thank you for reviewing the patch!

-- 
Best regards,
Coiby


