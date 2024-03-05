Return-Path: <linux-kernel+bounces-91652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B98714B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5004282F66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9FE3FB9B;
	Tue,  5 Mar 2024 04:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmtDUjwi"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243A2940D;
	Tue,  5 Mar 2024 04:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612587; cv=none; b=MDJpEV5FwjlbzJanKMIJBAVmIBJmL0WnSHjGHor8865sAxS6P8ZJENdHEuhiIDH9osurIx5zLQ0b0KXI74UaOSaklHLzF1HcGEkCqw7QUGpUXecYntK2goD0uVbSy7Bkz5Xz5f6JeCSGHhb4mHtZo2oOafWQEMRv/NXlP+c4L8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612587; c=relaxed/simple;
	bh=yQNBbjLLiqAPFBqtBerGf1G2HRZprMYdpTiF0eQeK4k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ky1PmfgXoUDPXvc+q9nBKc1GJSUzgyOlaLY3unz5ogR1IEZ49944+nI8jTKrv6QOZm5uluUF1L9/+RS3w26UWnV9P5gvDTQF68wiyKali65UCXiPkYviW+tRJkQ8I24WiiJv01G6oVr5n6pC5JprVzQoJTzvQSBI7Yxf5LLl0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmtDUjwi; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c1f582673bso579866b6e.2;
        Mon, 04 Mar 2024 20:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709612584; x=1710217384; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzMmBUOjgJ7iR9AaCreLenUOKeyl+lWeAI9zCHfBr1c=;
        b=lmtDUjwi7DcyV5PGQgdtZsYF1fz07cw9n9zUeLoSRKZcpFT0c7HBQf0xhbe/Y0+3QP
         QeTDiMXgMolcsNOyrj2q4W2mlWZtroJmbZzS8ism5LU/tViKvkVLmo+iCfo0gHFPybHb
         e+83DFVC2QBa0wAoiQXsfC/7PELv5LcxvFpfkiS59jomrfBtye8exsAuoydW2rueftzj
         jWgizpOY2iyReCEVmdybJX7WJAEofWHgwUESpPA7V0nrg7vQ53H1vNPYTtcGrSyRMrnr
         YLjdcqRUxFk05xZPKxQOiwLpQaaX4jgE9ypEqFTxyRLWYez+1X46TVUR6F/GW46xCcAz
         mKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709612584; x=1710217384;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fzMmBUOjgJ7iR9AaCreLenUOKeyl+lWeAI9zCHfBr1c=;
        b=slYs+TfxmYy4eWzuswuyS56LobAXCm4SLbczxBavcMW/szcN3780zqxdhhT5NV+5W+
         xYQSr1vrMEoOk8cypH26JprbffnJB4JM7rcIqa3YyXEmkAKmnkzZa2r98dfM4n6BU21Q
         k5DoUgN1dFG3lo+YlT7qYS/RGKZutohr6PUyzLoRbdvmcgFWqRl3wIIK+C7kYQBctfsv
         gsLpnVeZ3jyGxk/IBq0mbzMY6m6hjxsIQUVJvpf1EcpuHpN6MCXZPy+am5woWYpCw/b+
         e07aneZ49+pSog9BtA+fLksSWgkY0vVlIwdY3zdnnsL3D8S9Hf5MFSCkdNg3Reu0Y9ee
         vJrA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqsjalYf/GCJTN65E/QNEv/0omGqc+DzDo/BVLtTxozraxizsCU3UVU09sbULdUoIuiof71biaPb80QDUsMe5l0U0mknh7UNGjQS4fnPGHKgYtP4F5cjcRrhtssZo00n+t6zp0CxnUvktv8Ai9TnGiZSXiexkmq4QqMlc+1Mt
X-Gm-Message-State: AOJu0YxF3rGoyDrWM1gu/1eSj/a8vLyQ8itUnJvHt4cKoCBcbvvOBC+Y
	//81mko7q2zZ/3zsV2KD7uynhAxd12AUv7uY2An0aThjT7tBZA/2
X-Google-Smtp-Source: AGHT+IFFLUatCbrLcMXVuav5X7tGY8ZmQkBrBn5N3BUtEsRTOKjsncHTzek04PM66AOZAh/JjzEGcw==
X-Received: by 2002:a05:6808:9b6:b0:3c1:c9ad:7525 with SMTP id e22-20020a05680809b600b003c1c9ad7525mr703622oig.29.1709612584464;
        Mon, 04 Mar 2024 20:23:04 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x15-20020a056a00270f00b006e56d880015sm3050662pfv.140.2024.03.04.20.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 20:23:04 -0800 (PST)
Message-ID: <e876e3c8-109d-4bc8-9916-05a4bc4ee9ac@gmail.com>
Date: Tue, 5 Mar 2024 13:23:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>, Breno Leitao
 <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Akira Yokosawa <akiyks@gmail.com>
From: Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: Makefile: Add dependency to $(YNL_INDEX) for targets
 other than htmldocs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit f061c9f7d058 ("Documentation: Document each netlink family")
added recipes for YAML -> RST conversion.
Then commit 7da8bdbf8f5d ("docs: Makefile: Fix make cleandocs by
deleting generated .rst files") made sure those converted .rst files
are cleaned by "make cleandocs".

However, they took care of htmldocs build only.

If one of other targets such as latexdocs or epubdocs is built
without building htmldocs, missing .rst files can cause additional
WARNINGs from sphinx-build as follow:

    ./Documentation/userspace-api/netlink/specs.rst:18: WARNING: undefined label: 'specs'
    ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/rt_link'
    ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/tc'
    ./Documentation/userspace-api/netlink/index.rst:21: WARNING: undefined label: 'specs'

Add dependency to $(YNL_INDEX) for other targets and allow any targets
to be built cleanly right after "make cleandocs".

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: stable@vger.kernel.org  # v6.7
Cc: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
---
Hi,

While the first offending commit went through the -net tree, 
I'd like Jon to pick this up provided there is no objection from
Jakub or davem.

I know there are complaints against generating files under the
documentation source tree (thread under [1]). 
So this is a tentative workaround until someone comes up with
a proper way to fix the fundamental issue.

I wouldn't add Fixes tags.  Almost all the people care only of
htmldocs...

[1]: https://lore.kernel.org/linux-doc/874jevjgvo.fsf@intel.com/

        Thanks, Akira
---
 Documentation/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4479910166fc..b68f8c816897 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -111,7 +111,9 @@ $(YNL_INDEX): $(YNL_RST_FILES)
 $(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
 	$(Q)$(YNL_TOOL) -i $< -o $@
 
-htmldocs: $(YNL_INDEX)
+htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
+
+htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 

base-commit: a800c6f5b0573847722c5ec70e0ce5cde6ca13dd
-- 
2.34.1


