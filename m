Return-Path: <linux-kernel+bounces-6816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5F819E03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46682B23A24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F121365;
	Wed, 20 Dec 2023 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiCGQbDj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D121358
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f30d74b68so27343256d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703071714; x=1703676514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcGG20SZ9UCuGoY4ieTF40E4xDyL6a01++66TUtS6is=;
        b=AiCGQbDjMKLPwp3JI32A2goxcjSZC6vo3Od7l0atkWxkYOB004BZYmRD6zyzipStoO
         syCA/UtfNw4vxP1tLVbi1nP/fe4nk+S1XnVXImT7qo6masL48IP3TzQ61YvDSK2/odie
         ra5EcTlNzMHwDmpLePUIcrstCVlzPxeVARrStffztx2Od14SjXslAdOQfPkXg3nhb4sH
         cMsw6Kja8Hpmu1nJBin7iQDq+iUS8avTPTtdEWFQw10neM38QVwVKPixbS0gbmXYgA3+
         j28Jrj6xtkd1jG/O5XISxAZTxF+obbVRA1dQQu7ADfAsVOCvhjwKd9CjRPCr1prnOZbl
         SHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071714; x=1703676514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcGG20SZ9UCuGoY4ieTF40E4xDyL6a01++66TUtS6is=;
        b=aqhZrbm3P56tIhF652iFQXUUk1EU7vO0LPnEjhz8zcFRwb1atHDiXB1htKh/FK/itb
         mlteizwFY/K0XS8XYAWUVuWjPoHgTdo+M/1hyUOZLsCsj1D5uR7CFrX3jrJpoiFXobqY
         XizuYvWFcKPAQswRdtNhre5Vt+0yQDduQ6uqKtfrhXsNzCyCUVVBDpKBGMpB7SXRuMng
         3CeBz7epej1dVFJwYjnfpP73HKIzPPP3nPq74qNDzjCA83EXidrhd9AkJ+gKES9dYqm8
         m6eUZc+19plkIN5x4i89E3fbmhOnkHjJV6dOqB6MDBz+BGzHDpD+tZPKbp9Fr4CfStxA
         RgNQ==
X-Gm-Message-State: AOJu0YyIaS/gAh6Xfyqsx7CeoyKgY16AEQAuAur+wD90F8rureK4pxBR
	QKdYzaiksT2AZSDsDbv4miWaIdLJMBBK7SqYZki4Yg==
X-Google-Smtp-Source: AGHT+IFZWUI/3ZtmtxtNhXDaQSExCQzZlj9wAWUtGTpscIeUIj5afAcZSYxSN1IUBLYASdnV3PlG1ATqJd4ohbhERr4=
X-Received: by 2002:a05:6214:d47:b0:67f:3d14:4b6e with SMTP id
 7-20020a0562140d4700b0067f3d144b6emr7374255qvr.130.1703071714268; Wed, 20 Dec
 2023 03:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213233605.661251-1-iii@linux.ibm.com> <20231213233605.661251-34-iii@linux.ibm.com>
In-Reply-To: <20231213233605.661251-34-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 20 Dec 2023 12:27:53 +0100
Message-ID: <CAG_fn=WP2ZPdptOoEnCen3BuYs3EgB1nNfmoxDnC9LZK9r4CrQ@mail.gmail.com>
Subject: Re: [PATCH v3 33/34] s390: Implement the architecture-specific kmsan functions
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:37=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> arch_kmsan_get_meta_or_null() finds the lowcore shadow by querying the
> prefix and calling kmsan_get_metadata() again.
>
> kmsan_virt_addr_valid() delegates to virt_addr_valid().
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

