Return-Path: <linux-kernel+bounces-10335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC281D2E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0AC1F22FE5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719179C5;
	Sat, 23 Dec 2023 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOtDNDJy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C59441;
	Sat, 23 Dec 2023 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ed1ca402so20323785ad.2;
        Fri, 22 Dec 2023 23:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703316282; x=1703921082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jORh9fw7nr/hSfxeUA6D1R76ciFhMQw7mZ7t5scr0gE=;
        b=fOtDNDJyIFNKf2xxoraZpruZfSW4uRonpaDTpIM+uv5PNPf63r51gKX5ummrua0g5m
         fmqDk036TC37USb/RawOdGl3CgZeu+yyy5IectZYbvDw+n6wF+50gCTG1W8rnD2EtR1c
         w5NCYp7635xnNQFOboaufIPGcSNtby/nCwytUPAwF+Xr2VAcevicEQf/+3aJcg2GtQAM
         rQhi+PVh7lAmQcC78wd2W3XOQUYakBg1pO1i8swXh2d5gxcF47ojedp4RVXGKdPhZe5Q
         0pcI+vI5J3WjJGGhDq+vvTEGwh77GDQO6OQR/N4Hzzj4F5qvbH6CzXQcJJmuNzr73mDH
         UMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703316282; x=1703921082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jORh9fw7nr/hSfxeUA6D1R76ciFhMQw7mZ7t5scr0gE=;
        b=f+wNrH3xHORW9700supCYvS3wmyo6PbyKW3TKguxL2cayYgOZEEHRvrCF30NeukkfE
         WDaIJ/fVs5yPZ2YcXBs/m6RoD3IgsV1OlMz1wuuAZn/mb/3vBc5bTaLqlJQMK4GdACc/
         8/pHvnXoEZftxWGdZaaxbDvgXAPmqD4vngwBrPx1p2XoYuuo9AseA6iZ3zAHZ0HH+OWh
         CrQ/rcJ9cqSAyADXazsXIPPD+oo7GLzpkkLBr00kHQDFr691jLBGe4YNg6eQ1RAAvYCZ
         Z8Y8d6de8Fb4pl0i0cuTnMlCbbJVTaTE0Ecqk/Yj0TxO7gf8fgSPBVZLO0NTW3AZSTjL
         6KFA==
X-Gm-Message-State: AOJu0YxrJmJXV1duNa1aNJL2v+whakeOpKswvTx7UZA61oqoduYseuHk
	OVJUKo/nRpUKLrK9idTIo6o=
X-Google-Smtp-Source: AGHT+IHDROTw+qUqQ5s2W41ci3hSL+ozkJgbTmX4v4D4Q+t8ankXeHjijUG90Hp1ejTPeq/3YR7fqg==
X-Received: by 2002:a17:902:e88f:b0:1c9:c6f4:e0c3 with SMTP id w15-20020a170902e88f00b001c9c6f4e0c3mr3346030plg.62.1703316281854;
        Fri, 22 Dec 2023 23:24:41 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6810:f806:ab04:8efd])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902dad100b001d3f42edb4dsm4483746plx.294.2023.12.22.23.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 23:24:41 -0800 (PST)
Date: Fri, 22 Dec 2023 23:24:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v1] dt-bindings: input: convert drv266x to json-schema
Message-ID: <ZYaLNkYRt_WHzvCD@google.com>
References: <20231221183109.684325-1-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221183109.684325-1-anshulusr@gmail.com>

On Fri, Dec 22, 2023 at 12:01:08AM +0530, Anshul Dalal wrote:
> Convert devicetree binding documentation for ti drv2665 and drv2667
> haptics driver to json-schema. The previously two separate bindings have
> been merged into a single drv266x.yaml.
> 
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

Applied, thank you.

-- 
Dmitry

