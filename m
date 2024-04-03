Return-Path: <linux-kernel+bounces-128958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449DD896241
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E901E284622
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA83317995;
	Wed,  3 Apr 2024 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntga7ORo"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6C14F70;
	Wed,  3 Apr 2024 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712109527; cv=none; b=F77i5u9P780/84ajp1nqZnxce6JWY2mpFD7OPwn0mp785+HkTwkqg4CVMhGQz/H+uR0F+YnpteaKaegC8HfUbrdkhmAIjLYF7fxNfVw237TFb8x0QDOeOCAkLYWWJmr0SvUafQIc1hfZn3FN06YPx2R45i+b0PRlcMdlC6oeoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712109527; c=relaxed/simple;
	bh=P5gMzQDSLC5kMsvczBxa8S7hTV3vMPUzG5Tk87DXxek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev2aO9ZWIpXeKXTJTh2gqnY3VrxROdCRjouCatLMGT13zb0BIpn+vE4ZViD5T2GvOao+gMPO9+rrp4QTWYO6CBXjVqfHj3Iyyp5qDvglgx2E+JggLKiESjna7zYhm5N/iRzeZNGTHV8J+R85qyINYHZDvBFq/1YpPEjdpjGSI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntga7ORo; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a466fc8fcccso743262966b.1;
        Tue, 02 Apr 2024 18:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712109524; x=1712714324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P5gMzQDSLC5kMsvczBxa8S7hTV3vMPUzG5Tk87DXxek=;
        b=ntga7ORozf1eJhUyPAmApfYEQY4r1sm/DcSnUVUYD4fr+pBFP5+j0IhRgqYNIwlHu9
         Grl68JPeS1Vvho3JbV5i/hqIHT0cbZCoAyUfle+impGWPAelSgwCLgWnoaGk42SUFBpb
         zkQybN17BcgOSZGZXSAZD1EzddW9MTTwVRmwJaU12QHTjI0CEdVvGmaNh7Y/JPK+FkY/
         i4MMJbTnt7007fVlMyZpo5I8PUEeDP7XdLkWYM5emGPL9JOV/1lp56lJBOo5JNX8t1XO
         qLXf2ak02vBew0scChpWXnmyYPUOqGSFTWG5OGuy9LHA57TAEYdUtYDhVmXbpTCNd3bR
         7sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712109524; x=1712714324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5gMzQDSLC5kMsvczBxa8S7hTV3vMPUzG5Tk87DXxek=;
        b=qGzwT1bF7arxm8NfSnUY0ktFb51O3pljpDr4tbAVI24uyQ2SYcYMEx0jHWKWZmIC3L
         xgQsQ/8xGf/OKA5HjZNAfSVs1ec6VMFIimxDBIcnl/YuhfSnlYkdbk+erQGgTnm3b2Ed
         PfKTynL4VJQKgKaBN+XBFb3Ipb4riU6bakV0AZhJkUKpkI1E8BcFgGDosIXDfViU/ISi
         qj0a2RWmfGTMfx9rVXxiv8b/HfoufQXrW0w9R2GRPfSYEJe5V9RRNPOgDBOQt1yIENaR
         C2/JHBTXLe/1lcHlUPJ8rR09srsPVHpqMr+72zWVNq5BJD5UBkhH3iVFcyseiBpY107P
         2x1g==
X-Forwarded-Encrypted: i=1; AJvYcCUN5w083yobeAheuYva8UMCZ/gxOUp6qYSMKPSQIuKD8BmfVCRRJ6NZw/BTYQCaBvKqScyZwAgmv6Gqn60o1KDFVjK3UyxUYufBAZmo
X-Gm-Message-State: AOJu0YyMXUS1bQUMK/nI2AYiEmnAnkuM5erKQFdQkvU7BdYzKbKaswEL
	wSyNP5iiDG9VfkGV6Cy14P063V4gc/jdYOgrMnx0qoWX50e2pk6MHy9QxTWjrRLDw5/2xSeFY7O
	9eXF5l0Qd9fDeeB91rYAG6+vVq0A=
X-Google-Smtp-Source: AGHT+IHhzeOSt16zxaIQe+QZT55B1iDcstdCdCAAubzdydc0eDyoR2JXnSmKzxRvJVi30HDJZH0KC77enNH9TYS68Sc=
X-Received: by 2002:a17:906:39c2:b0:a4e:7f22:cfc2 with SMTP id
 i2-20020a17090639c200b00a4e7f22cfc2mr897367eje.28.1712109523766; Tue, 02 Apr
 2024 18:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403014006.969441-1-qq810974084@gmail.com>
In-Reply-To: <20240403014006.969441-1-qq810974084@gmail.com>
From: =?UTF-8?B?5YiY5oCA6L+c?= <qq810974084@gmail.com>
Date: Wed, 3 Apr 2024 09:58:07 +0800
Message-ID: <CAH9++vHEB7+oyYk3kDioiYCFf9Z=-EjRG--vrUBx7J6QdKRsMQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: Fix a possible null pointer dereference
To: james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@outlook.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm a newbie in the Linux community. Due to my oversight, the patch I
submitted has an extra blank line, causing two consecutive emails to
lack a subject. However, these emails are identical in content to the
one with a subject. Please review the email with a subject. Apologies
for any confusion caused.

Thanks,
Liu.

