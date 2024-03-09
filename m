Return-Path: <linux-kernel+bounces-97924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D538771B5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2587A1F215C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06743ADE;
	Sat,  9 Mar 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuPmQ3l8"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049E79DB;
	Sat,  9 Mar 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709995884; cv=none; b=PiZk0hP9TzuHq4QLFxnzTZvzM4kDNjv5nbVfMeOimt5nuiIzygARe27iAnslHT+eF9GPECR/FyE5m5eRqD425t6z5PG3jpe/9jCO96xEXJDffCptHlp9FUbAsi9fwo9ZiGLgWvtMXwWKF+wOPHIF82Z8XqhCm77VSfwFnZZmKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709995884; c=relaxed/simple;
	bh=D5J5SEP+6OfPVRUu5s1VyefzTSu8eHTF9vyDlwm9kt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnZPUzlXxnpRv8jqH3fySQuzUieVxURoxB7LMwS/tmKv7eWWpBqsItZfs2XSX6ijy5hcdYPoNozmBJaJ37WsdYnxu7Hq7N8hFLchA0xxtktRqv0lJosiYgVGeQ9w9HN5EQ953mIRx6a1ZgQVxg3ABMVkG4pulYkLx5/S/aAwpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuPmQ3l8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd74a009bdso3874165ad.0;
        Sat, 09 Mar 2024 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709995882; x=1710600682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5J5SEP+6OfPVRUu5s1VyefzTSu8eHTF9vyDlwm9kt4=;
        b=TuPmQ3l8KRMKQV3Qm5XXfU39Z28e0NMI+Vhx+9y0XJKfp7oMCIwKOplC7i1GR3vTSx
         ibtu54gypdNhGmeHTlSX3gyz5A92UA+eCQdEDAQ7oN9MF4tDGEttZsv+9t+/OOphXI0Z
         nw/7lSK+xqXUetkdvQzYGiM7kxePMpxpOrs321dhrtCg8zuCvmajC2IvhIhJQPRyvc7Q
         oCF37qRbjBC4TKb2bHZzbIoy+mf3e8nbDtI5YD433aZWaveh7X4ja2yJP0KAZ+59yJBC
         is62r2Xj7U688G8lPBGFLX4xacHzEtd2I2WNp4qx4MTv93PLYhSebks1L0ZEAYfOCYv3
         UNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709995882; x=1710600682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5J5SEP+6OfPVRUu5s1VyefzTSu8eHTF9vyDlwm9kt4=;
        b=xAZuqqr/SaSAkvU+Qkvo1TBBKmAWbhlfTkuRquKbYgq+7liP4+x8c4wTQtwx/0D23M
         OYLM7CDClAIKfiboLxFLjixzhbX1ugGC40NwAzwyEkwGnOUMWgrcFFrPtW2d3oZfJObY
         0IF0RqrdG7EcsUlAGk8rz/MgpZaW4OXihb/+9bfxOO58lf/oOaF6Cy7V0aHA/lf3ibrg
         Vs9sYpqA3ricz9Rsmob8BWlI3x7RSZEwRfLbSLbn8B2OYM4JLeBHzru0zQGfnE1XJ4Bq
         iq5aGvNsOBvGnGQb/IQ6VMcCfCgtheY8WEEYGqmc7W0rrOO6ZbSuENuwmlY9bqiFxbn/
         CNGg==
X-Forwarded-Encrypted: i=1; AJvYcCULpkYW/k/DpOg/RtG+0xRl+jHoGBKM6hDgE0ukHF6BRkklCLOGESUEaQahWP/KFze5bUZxxwUsmC98quRvyDYAFMNhgneRA3aQAWLb3AL1ZafubvlNA5vkuxI5D+pyCHniIDKbfrhSPneJvralnbQYClIpUKKRI7cexVVMKR0BtiJnGg==
X-Gm-Message-State: AOJu0YzyK+RSBn46LXMHEf6slTjMjxHqA3m7V8GoLQCGeluXcBdR6Kdw
	//RSKuPfdZRAa5b4w2HNbrZjV11Ec+JJ6HG+PfhEi2FVZlO5dELqST1KenYYMawPu+r0k8ePlHX
	cEnz4eOa9PTUY3EWLne89Z9S30UI=
X-Google-Smtp-Source: AGHT+IFQxtlBXHLMRdmxNIjXa7EVDuQgFAeVlY7V5pJP8BZdLTgqtdoQFyopNoe8BJC5z3geiv23qh8UI6MzwDaqh9Y=
X-Received: by 2002:a17:90a:e64b:b0:29b:780c:bc6f with SMTP id
 ep11-20020a17090ae64b00b0029b780cbc6fmr1614117pjb.0.1709995882225; Sat, 09
 Mar 2024 06:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81e42a64-03c5-4372-914d-9f2df517dcf7@linaro.org>
 <20240309134810.352428-1-animeshagarwal28@gmail.com> <CAOMZO5BBWmbKBJQS48R6Lfa4ua=vhdseHd0vSC+t+OOZ3QHHUg@mail.gmail.com>
 <CAE3Oz80xEpdnUq6JkqXgf_LAM5dJP0TbCHkuPW-KzRVUD95FhA@mail.gmail.com>
In-Reply-To: <CAE3Oz80xEpdnUq6JkqXgf_LAM5dJP0TbCHkuPW-KzRVUD95FhA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Mar 2024 11:51:11 -0300
Message-ID: <CAOMZO5D_F8enKAyCkvU5hFuET_U+u0gviiWCe=Oq1FhAQzPqjg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: imx-pata: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: dlemoal@kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 11:44=E2=80=AFAM Animesh Agarwal
<animeshagarwal28@gmail.com> wrote:
>
> fsl,imx51-pata isn't present in the txt binding as well. Should i add it?

Yes, you need to add it and make sure to test it with 'make dt_binding_chec=
k'.

