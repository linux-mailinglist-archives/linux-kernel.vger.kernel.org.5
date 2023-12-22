Return-Path: <linux-kernel+bounces-9267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A086B81C32B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC4A1F22CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23791844;
	Fri, 22 Dec 2023 02:45:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08A15A4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.VqFifUn_1703213099;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.VqFifUn_1703213099)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 10:45:00 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: yuanchu@google.com
Cc:  <akpm@linux-foundation.org>,
  "Henry Huang" <henry.hj@antgroup.com>,
  "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
  "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
   <yuzhao@google.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
Date: Fri, 22 Dec 2023 10:44:52 +0800
Message-ID: <20231222024458.12441-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJj2-QGqDWGVHEwU+=8+ywEAQtK9QKGZCOhkyEgp8LEWbXDggQ@mail.gmail.com>
References: <CAJj2-QGqDWGVHEwU+=8+ywEAQtK9QKGZCOhkyEgp8LEWbXDggQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for replyting.

On Fri, Dec 22, 2023 at 07:16 AM Yuanchu Xie wrote:
> How does the shared memory get charged to the cgroups?
> Does it all go to cgroup A or B exclusively, or do some pages get
> charged to each one?

Some pages get charged to cgroup A, and the other get charged to cgroup B.

-- 
2.43.0


