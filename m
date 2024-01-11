Return-Path: <linux-kernel+bounces-23438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609DB82ACBA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFFD0B23016
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622515497;
	Thu, 11 Jan 2024 10:59:32 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864C314F65
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26f73732c5so609285466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704970768; x=1705575568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9UdkkDp8qRb0Sxv5cn4ME3xe3myOJpUJJM+BWfPPVQ=;
        b=ZHXglfzJRTF3RmPpRO34OV0yhr9V6Wfm4iB0hwuUJXOwIIqFSDts5XTEQdIFTsbuyM
         wZt0etbqcOEacjH2XhDzm1IBnfvj4iujqjHtHJ8RTms5vXLPBHnnn46poizGNhFTP6Mh
         tzznJXHnH5XZ8RkGjhM1Dk4k2WJl/Ooej11kA8mazmzr2Xo4ochMalIkzebT6LMPqH9m
         /5IHa6frASesv7OBF1PsWAXOtRsqbVjxWLO6XBgWFUESsa4WBaShLbgHi69mtAFuEcRl
         A7vuEEA2Zxpjs7BmHVjcpM9mRgoWCYt3haWSgrgYSvDHQ4KFZXU33hzuBsKYPKSgYr+k
         KIuw==
X-Gm-Message-State: AOJu0YzaO4nXqI2jbTwe5f9WEPqZ5RoSs2Dl+RYooWJ7JC+xTA2UtGsW
	zf0es6PtRHm6dMbqQJ26bYpRNm67sg2ZA0+A
X-Google-Smtp-Source: AGHT+IFg8iTlgZRT5QsliaEP5Ohr4J6PMSj9FwFcWqpmSSF+7W5BjwDqfBkzpQK8Fk/fJPj7AgYdNQ==
X-Received: by 2002:a17:906:b845:b0:a2b:4ab8:d87b with SMTP id ga5-20020a170906b84500b00a2b4ab8d87bmr423190ejb.139.1704970768313;
        Thu, 11 Jan 2024 02:59:28 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709062b1700b00a2a67731f31sm430962ejg.109.2024.01.11.02.59.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 02:59:27 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so140677266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:59:27 -0800 (PST)
X-Received: by 2002:a17:906:d78a:b0:a27:9365:ef73 with SMTP id
 pj10-20020a170906d78a00b00a279365ef73mr456090ejb.38.1704970767622; Thu, 11
 Jan 2024 02:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa64c852-01c4-4e4c-8b89-14db5e0088d0@p183>
In-Reply-To: <fa64c852-01c4-4e4c-8b89-14db5e0088d0@p183>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 11 Jan 2024 05:58:51 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9ahyp+asVHCcMr7KXYqDRzxJnQmqYcz1V+LH3ZEfT+Ww@mail.gmail.com>
Message-ID: <CAEg-Je9ahyp+asVHCcMr7KXYqDRzxJnQmqYcz1V+LH3ZEfT+Ww@mail.gmail.com>
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jason Gunthorpe <jgg@nvidia.com>, jirislaby@kernel.org, 
	dhowells@redhat.com, linux-kernel@vger.kernel.org, pinskia@gmail.com, 
	kent.overstreet@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 5:56=E2=80=AFAM Alexey Dobriyan <adobriyan@gmail.co=
m> wrote:
>
> > SFINAE giving inscrutable errors is why I'm saying C++20,
> > since "concept" means you can get usable error messages.
>
> I'd say concepts are irrelevant for the kernel where standard library is
> tightly controlled by the same people who write rest of the kernel and
> no external users.
>
> static_assert() is all you need.

We have external users all the time, though. People who write external
modules or new modules would fall in that classification. Why should
it be harder for them?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

