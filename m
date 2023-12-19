Return-Path: <linux-kernel+bounces-4614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB940817FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0212816EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A360379C6;
	Tue, 19 Dec 2023 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5lRuXM/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B407468
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d89f278cc9so861107b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702954053; x=1703558853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC/Syu1LO9CGekxHr4hyDiqB1I8nqPv3BQMH/cbp20c=;
        b=l5lRuXM/oFZigd2dq8kx16aWTHzDEp58H460x+KF8EcTPIMcQFl1eUYXNFWk2KJTte
         JPPuoBIUyFGk3zljPVft9gjkULxBMPNR+pW2k+u+195VBRQvyNsZsAtRLb2G4IFVD9R/
         SieYfTvC+TmvgYCuJPxUZYK1QzReSmJswNAspsLFZKFL0YOM90zWEaL7cxlMqWlOIRQu
         MdrHXVgFmySps1LlM+XffdmkkRg6c3P3hEjTVGTUnQ0D+6n8yBi6fNxSLcMz+CkAskdX
         eUuQ4/st9DE+LDoaSlJh6q542va+ND3axviUhPNyXaKOVNdRliltmktA/vBquDQHXeoP
         9jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702954053; x=1703558853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC/Syu1LO9CGekxHr4hyDiqB1I8nqPv3BQMH/cbp20c=;
        b=GVav6K48bAn5te3SpCTQhJji7F3KvxrjG2yezz6252xFyav4Io6jvHOcsETOepV8hg
         H3J68J7xuFLW/Uol0XKpIZojMcpya7bZyiEhFLbGaHkqR7ejq9/7K+RKH/xE2sMtgHpa
         pFTiExSuQSGcHbeCp0OZP4GLKrkNb21/AIMdwjNihoydLJ/BPGclwQ29WUF8yNhmB22C
         yv3EBnpaYNofYkzhy//RfT90AsWACfqfYiAHnb/U1T56CwJeN2nHG/CXjyr0J5l4STWq
         UgZ+jFy7dYCZ9cm5PQkKkuoD7dcpQeDqfokcVP3e/+qZhOxzB2g5RTKFnGXqU+7qJVJn
         yiog==
X-Gm-Message-State: AOJu0YwXXo+oRgZahC85FOl/cUW8Qlfnq/q3IrbY/So5GDFXStLjmdPE
	s/e0hxtkD1OJCbE2ztaJmOk=
X-Google-Smtp-Source: AGHT+IHRNqb5kUfBYi12nhyKHU/bcfBy4RNNO0tbkNkX84gE5c5tAlV/+LxFS36wLXSa90oZaRNxvg==
X-Received: by 2002:a05:6a00:330c:b0:6d2:74fc:1f1e with SMTP id cq12-20020a056a00330c00b006d274fc1f1emr542127pfb.14.1702954052994;
        Mon, 18 Dec 2023 18:47:32 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h25-20020aa786d9000000b006d559d1a674sm3620275pfo.160.2023.12.18.18.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:47:32 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: fuqiang.wang@easystack.cn
Cc: bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 10:47:27 +0800
Message-ID: <20231219024727.35016-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2fc2ad7d-13be-4a9a-b984-67b1bf04c56b@easystack.cn>
References: <2fc2ad7d-13be-4a9a-b984-67b1bf04c56b@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi fuqiang,

Yesterday, I posted two patches that happen to address the bugs you an Baoquan
are currently discussing here, I wasn't aware that you both were also working
on fixing these issues.

Baoquan suggested I talk to you about it.

If you're interested, you can take a look at my patches and review them to see
if there are any issues. If everything is fine, and if you're willing, you can
also add a 'Reviewed-by' tag there.

The following link is for the two patches I posted yesterday:

https://lore.kernel.org/lkml/20231218081915.24120-3-ytcoode@gmail.com/t/#u

Sincerely,
Yuntao

