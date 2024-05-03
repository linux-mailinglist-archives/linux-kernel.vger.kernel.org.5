Return-Path: <linux-kernel+bounces-167648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186E78BACB6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C899D282FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C855152788;
	Fri,  3 May 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWRVh/1m"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A75AB67E;
	Fri,  3 May 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740126; cv=none; b=C0WLHV82EcLRiapX59+/aHyuWHngQcMwhHQ6KR/1KAepNBnAWKD5eHPlUoyfZm+j0ghbLaTQzDrPk3EIDHJBOhsE5w9RnLPaDJgQ72u1ZGNDDSFGaJBJuH1C8bMYQVUoX7fMEIyuMX0Dc0oWefEHfGNrOjJasKb6y4lyVdvgxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740126; c=relaxed/simple;
	bh=G/J9eaup46Lp2wuzVuRbYPvwBBE0WENMMV8HyGmYxFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFmFySjL11L3OLjAkSpA8KC87ltO1iK8xbhs3MdM6DBClGlILVq2n4IYWwJS9sLatWTQRBtZGC6j1+9K7hu+qShXDK9POVDni5e+Kk+vb9uqZ5Sapz2cSzRHg03rrQtMMO85hNDNSgLlRNj7THNTYwJ8WEPohaQlASWOBcu3HaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWRVh/1m; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51fa75d54a4so348838e87.0;
        Fri, 03 May 2024 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714740123; x=1715344923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/J9eaup46Lp2wuzVuRbYPvwBBE0WENMMV8HyGmYxFg=;
        b=iWRVh/1m5UiwBpISIoPmxNN8tJb6yUOUl7pZqtEuXOTrRAxBdZtiQ/c6RuoSTINfIf
         3xPkOzcaJw+FbOKQ4vwF7PKLPn6dMl01tGN7yGtKbtU8TPmZyhLLb/UvDE+S1PH2gBPi
         0B10KMDnR739uxKqBLQXffozJi06N97/F7wL713kBkgqBK6Xt3w2XuUHqfPmiORN6QUF
         FPsJeEsKB24lChwau1WvxYFB2yurop5DLN1lcRuOMfefYtm1b2ppAHW2HBt5Kz9qAEzX
         vg+fDu/MU5+cKXve5CQ3W/xa/p6BL4BayYo+BEf9sC76usH0nVVW8TnvC0mzgo8WsSYr
         5BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740123; x=1715344923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/J9eaup46Lp2wuzVuRbYPvwBBE0WENMMV8HyGmYxFg=;
        b=nYg52In+GSeQRzlzNdEdQ/1Hdw3eEUANCFL+KB+1YlnrdxniPSj5E/dg6ldSWpIDqA
         O+/ED0XtmfgvJ6j2XlIAXzx6tBxcawIZWuESCQk0oeJTMIaV+KtRioHR1TqIPnJFzUCF
         7rr8YmH5rtWA3oFFGFvFTs6iW+ftS/UkXhpMtCUcm8uetht0LDvZyKi3bBdBu53LTrGj
         ivzbkIbWu6Xnl2jaSz09TO3Uj6KWuIlxazemPVjUUVmlSefeyFdNr0dryqqV6fgPkq2a
         4aAFsQi9DWrxm00MjyG28pbajCPnRgD47fhR+1pwDv3UHCVcYKxS0JJOb7MJpZnFXkID
         N4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXXqHgTfXmkjDqJ+HWa9v4cCjsN+Mzwn5blihnkHmPJUtVLVwkA6UHvCRnt/dFJkokJ4LtO94JGaEJ/A/rkzUeauzHQiQYfqedBNPMW4N/E1tzm/dwgCxRL5Ktw0vruSfO2xhvDqTueeeI=
X-Gm-Message-State: AOJu0Yw3QNOlw7mATB0viMPHBFsDLYcoi4aAMsYpiJlirUZDka70o0BY
	OFkG1wmsMJihA/NjAl/J9PKXyrU3EwjMhpdOa+0n2nJcqpVx3Eu7
X-Google-Smtp-Source: AGHT+IG1cgOW3m6LEQ2pllDfXkzI1JZlnG1TYOba7QeLB5QAMTlpgbaGnqdAkmLpV2rFX4m45nKKHA==
X-Received: by 2002:a05:6512:a93:b0:51a:b757:85eb with SMTP id m19-20020a0565120a9300b0051ab75785ebmr2011670lfu.14.1714740123187;
        Fri, 03 May 2024 05:42:03 -0700 (PDT)
Received: from lpm-pc.appeartv.lan (195-159-183-44.customer.powertech.no. [195.159.183.44])
        by smtp.gmail.com with ESMTPSA id n24-20020a056512311800b005178e88b4adsm525371lfb.86.2024.05.03.05.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:42:02 -0700 (PDT)
From: Lars Petter Mostad <larspm@gmail.com>
X-Google-Original-From: Lars Petter Mostad <lars.petter.mostad@appear.net>
To: linux@roeck-us.net
Cc: lars.petter.mostad@appear.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RTF PATCH] hwmon: (emc1403) Convert to with_info API
Date: Fri,  3 May 2024 14:41:46 +0200
Message-ID: <20240503124146.220224-1-lars.petter.mostad@appear.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <521c0829-95de-4cc4-894b-6167c4f943a6@roeck-us.net>
References: <521c0829-95de-4cc4-894b-6167c4f943a6@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have tested this patch on EMC1438 (by extending to 8 channels and supporting
signed registers). This has worked fine for me.

Regards,
Lars Petter

