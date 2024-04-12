Return-Path: <linux-kernel+bounces-143220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3F08A35E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E08F1C21F65
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7714EC7B;
	Fri, 12 Apr 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l26RIRZ4"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F114C59B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947278; cv=none; b=Jh8UcvhsLfHcje5KkLYp8zO6g1b/Ee/yqny8k56VmSsvlMO2N6VSvTtE0PSCWeZ3NAMpmejzovuIgVCemktSvaGpbR9s6379YV2E6+8pvszlWNFUKMMSgYRhZZ0B4TJQqaH3aehAn1Dnrie4ib9/CU9bm5ajQ38R5f/CP43Pu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947278; c=relaxed/simple;
	bh=tE1aWPCZZJl7MoElbd+5YmoN+nAf47vnVFjNHq6stP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8YC45vh40rOrEAoU97Krdizrfl+Qss0gn69me16ga/SVy2GKFMqYOAV6eeRwUi6VSFRvMKj7OuG7iA/q8YCw5oXGFqfm9oP8FFraVYOqunDAcyuWT2UM+XpIfnAIEWPRk4xpYBEVGqlRXbp5UahWKNJ4XY8+6OSpFJC8pza1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l26RIRZ4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3cf5b171eso10138125ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712947277; x=1713552077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tE1aWPCZZJl7MoElbd+5YmoN+nAf47vnVFjNHq6stP4=;
        b=l26RIRZ4eCzxi0G54QsV1tN3DWAZAO9tvG6qBXVNlzkcbSDDrb/Zos8YXzxelXJf8V
         XDhre1ImCXQPFJaKJS+twP0WAqoVo4EUsxgAs/9NDL3OZjGrAGXWH1J3ZNi54bkbQrCx
         3/8wRsn1vJxP8lwTWV3HPKLWI/xhF1W5VoVkN2o2ZUNCR5HFd3ZiGqMmYLJd+hAkPnCu
         edXOYMUy4nN9WuUHlDdLhg5cObvrfIKB5Eo3zJCcOuAsHkAkLfGr3/fH6NJNl/i+bNo+
         xJDihT7hERjqJTcTLyCK0Wq12d9LK5+yT5lVQeT/hnQ90zC6O3faWI6KZaHO5TOSP+CR
         hMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947277; x=1713552077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE1aWPCZZJl7MoElbd+5YmoN+nAf47vnVFjNHq6stP4=;
        b=W634YmsihzBz22gtpziw+LINlEH5PKCVEtrqu9TNyBSYkKcf322bS7q2D9xCmaUtjB
         tLz8PDEc/NoxIsEPwGRSZieVQ5++LSpt76FS9X+tTdpUr2Q3gnT1nRNuaMkptjcEfQ9T
         M0cFtNhhqefn+grIvVot8Kt31MTTCuEBt+yvfL/OuJSwyLlIHf7xafkgQNTa9TR/1Z36
         rxQQHMCkikLYjz0clvJ14UuxV9A6eLOE0FEqaBdcM6Yy6gdIplv/2yakxAJm8vsi7N40
         o17PJ7/sHATa2StX+pH+R1shItsoOcRq+29pYfESqBDU82C07jTr21Rykpre6luwt9/H
         TuPw==
X-Forwarded-Encrypted: i=1; AJvYcCXBFdkYctDgJhIUlyCsQNek2Q2iBLD6ulXYXmuR8ZKBuDcEVKEdv/HUJBFZDugIsEKt8f3l8wrl+bMWgSqmRLYnBNy44OB6tZpwqlm2
X-Gm-Message-State: AOJu0Yxom1lFiXoTpYFbnW2gv2MN4UdgtcAYrSDWEA+DmchAFKD/jE+V
	3vtnEqTAz/apuB/H4b7xjpRzWcBlH+2TFcie8XeqKApw1M3HN4/FhYlk8JH04ASYixyHAlmaHeS
	yy5YA
X-Google-Smtp-Source: AGHT+IGQO04VC0zqxkXl9HI81WqEqxeP4e4k3T6O5AVuAZB5k5Q3DvX9OiYo61rtrsCcY43kj4509A==
X-Received: by 2002:a17:902:650a:b0:1e0:a1f4:95f with SMTP id b10-20020a170902650a00b001e0a1f4095fmr3460792plk.14.1712947276396;
        Fri, 12 Apr 2024 11:41:16 -0700 (PDT)
Received: from google.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001dd0d0d26a4sm3384097plb.147.2024.04.12.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:41:15 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:41:11 -0700
From: David Matlack <dmatlack@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Yu Zhao <yuzhao@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shaoqin Huang <shahuang@redhat.com>, Gavin Shan <gshan@redhat.com>,
	Ricardo Koller <ricarkol@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Rientjes <rientjes@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] mm/kvm: Improve parallelism for access bit
 harvesting
Message-ID: <ZhmAR1akBHjvZ9_4@google.com>
References: <20240401232946.1837665-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401232946.1837665-1-jthoughton@google.com>

On 2024-04-01 11:29 PM, James Houghton wrote:
> This patchset adds a fast path in KVM to test and clear access bits on
> sptes without taking the mmu_lock. It also adds support for using a
> bitmap to (1) test the access bits for many sptes in a single call to
> mmu_notifier_test_young, and to (2) clear the access bits for many ptes
> in a single call to mmu_notifier_clear_young.

How much improvement would we get if we _just_ made test/clear_young
lockless on x86 and hold the read-lock on arm64? And then how much
benefit does the bitmap look-around add on top of that?

