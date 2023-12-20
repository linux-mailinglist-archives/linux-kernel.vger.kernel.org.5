Return-Path: <linux-kernel+bounces-6498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C5F8199AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7322B284BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F3199AB;
	Wed, 20 Dec 2023 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEOSBAiW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979E16417
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e305530baso4458128e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057891; x=1703662691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVVt1fDDGnFJy0Xc9rDOy5tQYcz5E1cw4wOb1DmAjF4=;
        b=hEOSBAiWPBUTZY+bUyci5+9oe7MAMW7+nPw2VXKpyy00Mg1e77nSTQXxcrzTuVshZt
         UGnQq/ZnIz823z94yAzPQK+wF/Ox7Nt1qXmv1jpgdeqKKbnbtCbNSSvd8OElX8j96a/Y
         FPDjKaEY7syOuli0scR2QM+q4lzM6ofI+C7dR1qKlgEHj39CErimRPOHFWjYpbKDH+Uv
         BLwDYbWVaf6vSbBbxqiMiktSTdg8P3KqfSsZSDheRjsTDGvjXKuYjbGRhNd24HR3GEgw
         /1zhss3zbFx0Qd8jk47w1uDq/+eBwwEtTBCyYXOJrFzJSMwPfM1UOR7YhH7gSi9PmKCJ
         K9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057891; x=1703662691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVVt1fDDGnFJy0Xc9rDOy5tQYcz5E1cw4wOb1DmAjF4=;
        b=uQnAxzcvuNr0iYWpSlfKud73NMTgrRGQlZemzTZP0wapjpxlsUgao5mlXkuq60rcBo
         t9swE3w3kHCKJoRMoSniF9GXn52t4Xcw3aSMWKKEsmrsYqdu1fEVSDupjgGB50+clJ9N
         Y1DgE4NXJzj/cvSkYuhAUhK1Wb+WMrRhQNiPgiuXtgFsY06vlxub3IF4JkKnAjF1mnYw
         tFIh6B83jjJpnnaGSyTmz50Rn0G5xRTtCnnXZwN/dLKPSCNmoz1h4FcVfwCmJk8gOGye
         DITnnJgaTq2osj0b5Jwrn817sdx4ymiuwmKAjxqrmVAOYTdiLDasInf7ZpDcb6GDSOp+
         qvSQ==
X-Gm-Message-State: AOJu0YyKnMOe44ZNMrO/yjuMpIwWZn/l3PVreKsVstIjNi/CtNangsfk
	QeEDjmpa1K0hAfiTtkzGjQ==
X-Google-Smtp-Source: AGHT+IEFNKchB/1VHfNCRdiLGugNJGY2vX/742FVk8651mUTqZdoki5LBFSkYfc8gB1q1yTBurwMCA==
X-Received: by 2002:a05:6512:2098:b0:50e:30f1:8668 with SMTP id t24-20020a056512209800b0050e30f18668mr2461045lfr.56.1703057890779;
        Tue, 19 Dec 2023 23:38:10 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id p7-20020a056402500700b0055283720ec3sm5979043eda.76.2023.12.19.23.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:38:10 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: tiwai@suse.de
Cc: alex.vinarskis@gmail.com,
	alsa-devel@alsa-project.org,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	josbeir@gmail.com,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	stuarth@opensource.cirrus.com,
	tiwai@suse.com
Subject: [PATCH v2 0/2] ALSA: hda: cs35l41: Support Dell XPS 9530 (2023)
Date: Wed, 20 Dec 2023 08:38:07 +0100
Message-Id: <20231220073809.22027-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <87ttokpyws.wl-tiwai@suse.de>
References: <87ttokpyws.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following changes by Cirrus, attaching rebased (and greatly simplified)
patch to support Dell XPS 9530 (2023) laptop.

Safety-guard against capped SPI speed is added via separate patch. It is
not conditioned to particular subsystem, as all devices normally should
pass this check. Following suggestion by Stuart Henderson, error out
threshold is lowered to 1/2 of requested rate.

Aleksandrs Vinarskis (2):
  ALSA: hda: cs35l41: Safety-guard against capped SPI speed
  ALSA: hda: cs35l41: Support Dell XPS 9530 (2023)

 sound/pci/hda/cs35l41_hda_property.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.40.1


