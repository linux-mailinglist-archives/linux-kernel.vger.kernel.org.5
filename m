Return-Path: <linux-kernel+bounces-17874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F982546C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD721C218A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224A02D636;
	Fri,  5 Jan 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6GsFnl0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152CE2D632
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704461124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+N2QN09tRy41VD5NIYroenQi57udRymfLPwCbxVPuM=;
	b=L6GsFnl0JusZxOp1NXW8A3+9tu7sKg+HK9b+JolngGkhY5jpQi+SWJ6/1Vq2ptsA4dWLmf
	d9+lkJcPAzoHy0a23ykPIXd8RLtdZNUJH61mGmgO9lD22kU0N2Ed5T/yayzrU0K3H0JdZY
	icP7/r+EyuKPdPoBFFboVYXzhFeW3Is=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-0cT84_RSPsSM8i3FPTMfUg-1; Fri, 05 Jan 2024 08:25:17 -0500
X-MC-Unique: 0cT84_RSPsSM8i3FPTMfUg-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3601028d487so15531665ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 05:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704461116; x=1705065916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+N2QN09tRy41VD5NIYroenQi57udRymfLPwCbxVPuM=;
        b=YuoVlipYprQTq/u13PG+x8lTdR5UiBKu6K4vn35/LxvJ2w0JVIVuX08FezzYyIkguS
         mmJwJDw5PvvAlFBYEgLdtcH7kTcVsAFTCDLwhUCNqybmElVMatpXkw27I/4SCgVabZqV
         nXtgg91sVT8ntYaF3mcH3RPzQIUgUp00rVuEkSb+Jziy74EKFlwjqFiV/kD1gY7cJAWz
         hugPn5PeI6Ai2oFWU3wJOUXWyrz4NUzeqOHKGXdbH52Nw8mRK20uPD17J7a8olCsrdf5
         qv35+1eq7Yz5b2YEzvWcsz7Uby9380gVNRHdb8n6kliSLFuGg52TbBoYP51qtEe/xzwp
         jRIg==
X-Gm-Message-State: AOJu0Yzsw7OAu1XcsLhgGibm/Sg1I6t3Tr9Z3Toosd2DSVLxgBDwGS1K
	JwpHufznvNGLbGpXF8ARqsl7KK1v/vkY0Doi3QUcNxamCmHb4eOQl9pTzHqSA+K0yvJiX0JApNm
	GvUgiCJ1ugZpnVe2boFgSuPVNfKox9fyP
X-Received: by 2002:a05:6e02:1788:b0:35f:feb7:35e5 with SMTP id y8-20020a056e02178800b0035ffeb735e5mr2486084ilu.69.1704461116341;
        Fri, 05 Jan 2024 05:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUPQheyiFfY5luVUQI5Mu+aTbDrNLu5ERwC9srQCSZz+wyviXhwj8/teWqfyQ53IB+42HnPQ==
X-Received: by 2002:a05:6e02:1788:b0:35f:feb7:35e5 with SMTP id y8-20020a056e02178800b0035ffeb735e5mr2486069ilu.69.1704461116035;
        Fri, 05 Jan 2024 05:25:16 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q68-20020a634347000000b005cd821a01d4sm1383371pga.28.2024.01.05.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:25:15 -0800 (PST)
Date: Fri, 5 Jan 2024 21:20:45 +0800
From: Coiby Xu <coxu@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
Message-ID: <43dozoqfip7m6nglbwzwyzykx23fpzbp7d42pcqzudnzlfvfkb@yjvuo5a6suvv>
References: <20231227044156.166009-1-coxu@redhat.com>
 <CY54Q6U6UMKM.2H5N3BACDBGU0@suppilovahvero>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CY54Q6U6UMKM.2H5N3BACDBGU0@suppilovahvero>

On Wed, Jan 03, 2024 at 04:09:29PM +0200, Jarkko Sakkinen wrote:
>On Wed Dec 27, 2023 at 6:41 AM EET, Coiby Xu wrote:
>> Currently when the kernel fails to add a cert to the .machine keyring,
>> it will throw an error immediately in the function integrity_add_key.
>>
>> Since the kernel will try adding to the .platform keyring next or throw
>> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>> so there is no need to throw an error immediately in integrity_add_key.
>>
>> Reported-by: itrymybest80@protonmail.com
>
>Missing "Firstname Lastname".

Thanks for raising this concern! I've asked the reporter if he/she can
share his/her name.

-- 
Best regards,
Coiby


