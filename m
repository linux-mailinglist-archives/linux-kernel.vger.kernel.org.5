Return-Path: <linux-kernel+bounces-41112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78BD83EC06
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B254282C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ACD1EA80;
	Sat, 27 Jan 2024 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="kDMj4dfb"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669F1E88C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344016; cv=none; b=bXB2Gjk0txm7lI6AX18HS96KjnloY8e3c2HSzdFUiolnspTB48vEcvM8QQ9uizjHeT9h71V2mJ05mDknszqQIgW2c9c0eQGVRitRLzmfe/tz5YQ0QTGe+QJdQh3wswuy5bo6xApJHheDTNQ0GmTNx1lm/6qle4SNk6Y26pcwTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344016; c=relaxed/simple;
	bh=0ZcJQsLhZWh/yYW2Exmnxbqre8RfnYmZr+JOb/fNAlQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=SGdE1PsmQq4dIIZrvmiwJ08WHJDE/yreZnWoERUaFKASXdYfgYO3S8Gf2Pz3te26owNzhD9fUrRXXaUU7adNA5mmCzbXuV42EFxt9Rs9/mW9x2KsvRc8dqTwOLQfMCQ4XRNDv+XFXvDy99I3yBxFdj6O4n7iFKqz5DmPQb8dpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=kDMj4dfb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3169f46d73so34979066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1706344010; x=1706948810; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZcJQsLhZWh/yYW2Exmnxbqre8RfnYmZr+JOb/fNAlQ=;
        b=kDMj4dfbWtOcb29TVzBu9SUfAmf19j0C4ljS98Ly6o0lR1et8MceyOO8LhxAconLiS
         H6B2vQvLeIGq4pfFLI+k3JasWWQV3Qxa4nTBuzeBx9rJDjtUBWr/+g3O/TyJJvPXgo/v
         lBzWNwM1JTmh5wRuXg25cw3RenVgIgU0OsQVGg/eLpMTmphENN0GFnMTyj5hrof2ruPh
         6YDG31bCv3c2ZU1hso2HCC/2FMkLXBA7rS7K4P6IczNZqyOwJqlBbgTo8w6DpMyG39yT
         143KenVQEkhuq5HYm9gj/Jqn+Zlobcqi8cY8lvwjf4pMxbN6feYyqioSAlLMYLFI6vwz
         t3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706344010; x=1706948810;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZcJQsLhZWh/yYW2Exmnxbqre8RfnYmZr+JOb/fNAlQ=;
        b=B8Z8OvND5GLIfRvlj6d7rWl8c3XRy3R48CPDKV2ruSRIOGKshxbJPtgdiNeoOsDxYl
         gbrKOFfrmATyDJgRpu1sSnK8EF/XuWbX73mAoMsD5kPGmGCOGJ+toDkz+b/xEwz/4OrE
         W+blUbsq1HzjT98+N8mkg7hKCqnhAP7n2tLddFuUQlqVwCQvOUBkIcN4XLG7oQf3trkH
         oj7dVbnIKV8UvQ+HH/xBBk/1+rdUqI8/Lp/5LZFxmOTPG0dKlyEIiX7acZRN8Ll3FpUk
         atedvYfQiIX3XY7Y+eF+3ccjZaYx145auDT4EPTdBRHNCu0aZ/3Bii1Q8cssSwJDSyo+
         PxkQ==
X-Gm-Message-State: AOJu0YyIxTYKHLv923++WHGUoruoKePlU1FzWHS+pVcSJ3I3z7ps334v
	2CnqllMfHFAIp1x972u3IcsE9f2A+IAGoDuySvOBXKFO+X+s7B6wy4rSbGKAC5M=
X-Google-Smtp-Source: AGHT+IH5GPlHdnxblD9bjgkz4seFu3hVBl0p1VvML+Fg5/SBWeqi1q6fzsWVFg8pBqqdDOeM3qEMVw==
X-Received: by 2002:a17:906:1c57:b0:a35:3eb7:3b74 with SMTP id l23-20020a1709061c5700b00a353eb73b74mr498284ejg.3.1706344010096;
        Sat, 27 Jan 2024 00:26:50 -0800 (PST)
Received: from smtpclient.apple ([105.225.45.176])
        by smtp.gmail.com with ESMTPSA id mc4-20020a170906eb4400b00a338fedb9ebsm1525002ejb.54.2024.01.27.00.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 00:26:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Ezra Buehler <ezra@easyb.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] mtd: spinand: esmt: Extend IDs to 5 bytes
Date: Sat, 27 Jan 2024 10:26:37 +0200
Message-Id: <F3EF7144-ED08-448C-860E-D8ED898A7931@easyb.ch>
References: <adf1fa3b-33eb-4def-97e3-55a7231430d4@salutedevices.com>
Cc: linux-mtd@lists.infradead.org, Chuanhong Guo <gch981213@gmail.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Md Sadre Alam <quic_mdalam@quicinc.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>,
 Sridharan S N <quic_sridsn@quicinc.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
In-Reply-To: <adf1fa3b-33eb-4def-97e3-55a7231430d4@salutedevices.com>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>
X-Mailer: iPhone Mail (20D67)

Hi Martin,

> On 26 Jan 2024, at 20:49, Martin Kurbanov <mmkurbanov@salutedevices.com> w=
rote:
>=20
> Tested for F50L1G41LB
>=20
> Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>

Thank you very much for your valuable feedback!

Cheers,
Ezra.=

