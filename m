Return-Path: <linux-kernel+bounces-91368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B812687102D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE6E1F2198C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64E7BB01;
	Mon,  4 Mar 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNoUBake"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57368F44;
	Mon,  4 Mar 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591922; cv=none; b=YGQ8DYDN6v0XcanGQZzpP/Ks7Jqp0EBNqQljqcWW/R5R804oPaRTkcGVmyj/L9zMbhViH/r94U5L1xV6Pypmo8+M1aVq2v+ICIzgGf1srjmLjslS3mIdvsTIj06lc/wTS0HLw4mT7hOH+rOM9CN3BqhPfU/TrQvtm6/146mI55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591922; c=relaxed/simple;
	bh=Gn967GUY01TbnVw7J+amolBiTsybUNll2L3IweRe7x8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=es8LGaTuuudbv2zd/zf6zVy3fbEKVqCESKoVtiV2sW+RvpFPWwaFxVcOxsrLcqMdNcj8QZ5kcuESKIG5ZzOsx7+e2okQ7CnwzYil3hoqCIGcJ/+vYSmQm2EGMbCW63XlhpXFzdfqxrloxrl+biGdQE2T29FO0pTy+tHarnS7bRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNoUBake; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so3526670b3a.1;
        Mon, 04 Mar 2024 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709591920; x=1710196720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN8SwlbqyYdlyO4orHXGIO4nVPTlMFcHeme81n3Cn24=;
        b=FNoUBakedd0MBrblVk8mNK8LjJTEz4DlHsiNT0tX8bWkPH31DbAepT+job1jBW45FX
         ajqZ4/1Ph3GhUVnYagMP1dWkz/EnAFC/YlinXVSxONvCSba+ZE5iqE5E8Tk8REjSY3Y7
         /TMWLtmy5gyMcJNAHRdneqfcBBHpDXz9fLWHlrXIHNmsX3dIPdeAuSyfI2k2RwfAA7dq
         JG2Ra6R/QC5yP5+ihHiVY6Oss4qSnl/NTmBnL/t5ZYsdX8cSYJtsY5WfnNhTguCtA50P
         AcEVMMt6bSnazg1/HyaV5avUeihBa38JwGLu/x9gPzktix6Vk6dTNTbEkTSM+44dQGIk
         j1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709591920; x=1710196720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN8SwlbqyYdlyO4orHXGIO4nVPTlMFcHeme81n3Cn24=;
        b=GMnV6DqdzKWfDXHCy/eWW6GQ1X76W7JLQ1Yfn7zz/EBCfjeztmSXnetmJpwI9Zr+0G
         NM8EbOCBRcvtika5RqgaoI1dOMDErJ3u09mMaEHpcolZB8txDPQiSajH45pZtXLH2Jkm
         LkoqPYk6SmqfpzSyq20NSbNzT4K8h286S/XcaVJrjYeSJQPZwgwPVnupHqlmIVIpHF+0
         8ju8mKGBI4yPvWMhn2QDxNK7d4a5qNkBcdigHj3P5y2QiaBFqSqNyB8H6XpBSF0giVuM
         I0lAb8J2o67QPyu6Le3AUmuycMWCi5oLHqJzC7vf9BEYjDHJxheHJ+acOleEQ+VKFxcy
         VaPw==
X-Forwarded-Encrypted: i=1; AJvYcCVK4kqgE6nhiIImcY5aqJ/OKLvRH5IiffCocuathfz+1RrXIBFV9uOkLoQLLOEKJDdpRipGcjX8oxuCGXV5evUtXdR6SLUvBW9fFdZ3
X-Gm-Message-State: AOJu0YwoH6ufaM7A5ux11GzsUOuyh5aFiDhmHbRn5PP8yHjRb7D0Wgvp
	mxkJos5VdcgVJ2cA1JEZT7tLYCB8O31FrNuorg4/RNOB+z4QI4NL
X-Google-Smtp-Source: AGHT+IG8dU5/zW36h3fRi77tXNMaH85I+KnVTo+H3gSed/dcTydDNOJhmwTWowr49ZEFzcP95HxORQ==
X-Received: by 2002:a05:6a00:815:b0:6e1:338d:e01c with SMTP id m21-20020a056a00081500b006e1338de01cmr13090467pfk.1.1709591920061;
        Mon, 04 Mar 2024 14:38:40 -0800 (PST)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id y127-20020a62ce85000000b006e5571be110sm8069622pfg.214.2024.03.04.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:38:39 -0800 (PST)
From: skseofh@gmail.com
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	skseofh@gmail.com
Subject: [PATCH] of: fdt: modify small size memory check
Date: Tue,  5 Mar 2024 07:38:30 +0900
Message-Id: <20240304223831.11288-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAL_JsqKaZ4KcvfNZmn2gj+yXa8eLgzMpdhJJ=+OmMJPvzm-1Qg@mail.gmail.com>
References: <CAL_JsqKaZ4KcvfNZmn2gj+yXa8eLgzMpdhJJ=+OmMJPvzm-1Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> >
> >
> > >>
> > >> From: Daero Lee <skseofh@gmail.com>
> > >>
> > >> After page aligning, the size may become zero. So I added exception
> > >> handling code for size 0.
> > >
> > >That may be true, but when would anyone only have memory regions of
> > >less than 2 pages. In any case memblock_add will just do nothing. What
> > >is the actual problem you are having?
> > >
> > >Rob
> >
> > Ignore the previous mail.
> > I modified the patch to clear this size check routine. Please check
>
> You still haven't answered my questions above.
> 
> Though the patch below is a bit more readable than what we currently have...

Well.. I don't see any 'real' problem with this.
But I'm not sure if it's appropriate to leave a part that will be returned 
directly in the next fuction called. Wouldn't it be better to handle the part
can be handled in this function, rather than expecting the next function to 
handle this exception?

