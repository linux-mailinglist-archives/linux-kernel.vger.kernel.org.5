Return-Path: <linux-kernel+bounces-4608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C3817FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A641CB21BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0B468F;
	Tue, 19 Dec 2023 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWzREJj1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75A4402
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b9460a9easo956384a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702953760; x=1703558560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrNdaUd1I0ntnBi2B5c/DW3suLxtz21RcLr/EmZ7jXE=;
        b=JWzREJj1Miadp37Eba5cwrCZLY1jW4pXL9ofnfk4fXBFdkRxz86gtLFXKukX3XbALp
         QGDqumVC8vqgQXCyRBkdwEep/RZsHbQ5vyaqRxsRW9FOqAqZyx4NGeJbrXTYY4rCts3W
         jixcTgYe9022EsqddMk2IgCMLkK/ep6wulKhEqhuObpw7Lvl8xWs/KEgUhb9F/rx5egv
         BP0W1RC3X9wYJjtYfWVj2XJEgMJf3YLq+h/jZlO7jdUqOHi1kx+BbZF+4iNN5AIADRVo
         w9a2Y+EGkW3kxMNkS0h0wkil/nY31jfCZG8DR1r/NLsFqD4aykh1r4Kp3PIR52sRG6vi
         pOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702953760; x=1703558560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrNdaUd1I0ntnBi2B5c/DW3suLxtz21RcLr/EmZ7jXE=;
        b=hIP4oo0N/G2SgL0lRkcyfQW8ppa6PqWSuI0ijr5CDvPhWrgNBUPF8dCzzImX1o3Pni
         qg1+VlUlhnYhWL4CHRQqDg+b2vSjdLeUlzBqLRRuUWWS6WO91fkByuyEPYPTOntzJXVm
         tZMPuijd04m7WMZfMox9JKZEXYAEb8DzdpvmbrDwbsWbpnruejbvfHw+6Vy3amNWCRk5
         889Psb0IPz4CwycJxEZvzCkPCcg++tVT7fmoQrUIxn7QSi7uWlW09NQLlY1C1exqfxgt
         CM2jbo7fpMtyZH+zWIzu9/unokfPqSO4EHOD+T+wyHZnc+jZHHMQfxb4dmZcBLLDz6mg
         swuA==
X-Gm-Message-State: AOJu0Yw8RocucEPhVQgkKo83Q77unrRcSXKd4uTgKgPJuQKMN0tF1cgi
	rgBk9SqQwQjkJErAqdfGw88=
X-Google-Smtp-Source: AGHT+IEMr7SMf8dJkuy6k8qi1J/96oz87KZnHCi3MepwxjvtKXznLGUn6U8+nRNkKfrz5fYw7BLjjQ==
X-Received: by 2002:a17:902:d548:b0:1d3:7d0b:a878 with SMTP id z8-20020a170902d54800b001d37d0ba878mr3984676plf.124.1702953759941;
        Mon, 18 Dec 2023 18:42:39 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001d38cae83e9sm6468589plw.104.2023.12.18.18.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:42:39 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: fuqiang.wang@easystack.cn
Cc: bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 10:42:33 +0800
Message-ID: <20231219024234.34644-1-ytcoode@gmail.com>
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

Sincerely,
Yuntao

