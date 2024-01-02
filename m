Return-Path: <linux-kernel+bounces-14211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E43682191C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848601C219CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B581CA6B;
	Tue,  2 Jan 2024 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At85xMWg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2334579F3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336897b6bd6so9084886f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 01:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704189096; x=1704793896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kuCZwb4yiikdqhHg0hi+4XPLBDIk906WUFona5KsJc=;
        b=At85xMWgvrsRTD8JHJUfzJe/SJKmkoHDv1CT2d4p7Tzn+wGQRLZZycyFwf60tgYFgr
         uWRswAQIxWO0OtaPkjiXRglNJsnmIiwHap/08xY2yAYXvpzAs1fN0Nm/q63hOXriIJpy
         CtidKBYMegyLZWE9bklvtLcrzEMIg0V/ZesXgZuNW+IvQ6ZZAYJdRbvJU07+Ed19+bAL
         QaBLmcCMbYHji9UmoHYmteCJXeSJ64HTSwTt6cd+d57JWg7JgQwEFbZnQSfVl1DUhWNJ
         FuxIywsHnAwog5AP56t38Ph1X9/pVt1Sf+QwJjgUcrMWhYNOgTMgGGN3x4Emuy0FJZZ7
         yb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704189096; x=1704793896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kuCZwb4yiikdqhHg0hi+4XPLBDIk906WUFona5KsJc=;
        b=skW8o9u/jck5Z85FMzzKZsFq/VTl09JqCjkUfVYJQNKRJrRoWBAHEi7/LZj5rfsZXJ
         BUZmWLDrFa7HgevzTNsb3ZMYKgWQtEXH1F923pb2I//qI2Q5jHPlbDVFqw7v+g48Li+p
         eHHsKAQbf/rJAtqmA+xZEhsYO8xows+A/MX5Gey6pno4cAPx0T7x1gzF41hqXfIW1I8a
         7lsUKB4d4iAEbZcgrkzIAkztpi5KZcCdwkMDxv01ApYVjuhoZdpYIZ7Qk5ixFL/N9ZXQ
         vypsVKoRJTbNViEkKXCAcKRpMeTphZh3CwdUhNItfOxfoitN2T2PYm/A/jdJLbs8V8AP
         i5pA==
X-Gm-Message-State: AOJu0YyyXGSZBYLWt65CYF8DlJwMLAtnNmMxMp+yxNDLIHi6R/WnHyGz
	oHbuloqX8ht9wG4xaWvM6WQ=
X-Google-Smtp-Source: AGHT+IGGnuHrE7XyWc3Yjroii4M6nqFYGtl9FMcJqm2qZtx5JZ+mXcBFeQHQ2X+wozRdN0XzyTL8Wg==
X-Received: by 2002:adf:fd05:0:b0:337:3a0f:fd6e with SMTP id e5-20020adffd05000000b003373a0ffd6emr1757426wrr.60.1704189096231;
        Tue, 02 Jan 2024 01:51:36 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d4883000000b00336e32338f3sm16877254wrq.70.2024.01.02.01.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:51:35 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 2 Jan 2024 10:51:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>,
	"'longman@redhat.com'" <longman@redhat.com>,
	"'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'" <virtualization@lists.linux-foundation.org>,
	'Zeng Heng' <zengheng4@huawei.com>
Subject: Re: [PATCH next v2 1/5] locking/osq_lock: Defer clearing
 node->locked until the slow osq_lock() path.
Message-ID: <ZZPcpVJVfsPk06xk@gmail.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <714ca2e587cf4cd485ae04e5afb8d5bb@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714ca2e587cf4cd485ae04e5afb8d5bb@AcuMS.aculab.com>


Also, please don't put periods into titles:

 s/[PATCH next v2 1/5] locking/osq_lock: Defer clearing node->locked until the slow osq_lock() path.
  /[PATCH next v2 1/5] locking/osq_lock: Defer clearing node->locked until the slow osq_lock() path

Usually maintainers remove them manually, but there's no reason to be 
inconsistent: half of your series had a period. It just unnecessarily 
distracts from review.

This rule applies to this series and to all future patches.

Thanks,

	Ingo

