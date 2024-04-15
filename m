Return-Path: <linux-kernel+bounces-144584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813078A481E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2154E1F21CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29B517547;
	Mon, 15 Apr 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEeFL5Rj"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF14689
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162810; cv=none; b=RqRMzm6TWQEUE2sH8NNHnKPl/5SiEEC4kdWp9Tu90H2S1HR8HrKlD+AKqvvK+DdlZnvd0JOlC4Xgbe66XZC9hf12C7Exel0HL/aKlTJnvJc3BfvHKI933if9dy0giMDWbAKO0xyh5ozacRGkLGi5Atq2wCnVtYp6iKcIBzx3HQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162810; c=relaxed/simple;
	bh=gTSCRtiukqL2BYeOwjzNg/l21VRZzAe9//nU1tl1I5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVZZqMeTRFiKxDgu9q/lDdij0aUR2J2FTSkpUZs3wbSl7koq1cnqQJXflZfSX+7ojXRB3uhaFESdy3qr9qPmbwvFYzvBfJ5oXCmKhBXBiDZPVxSfvwagWQmYqXylOQPeE2hvfhXIelqfvYtUFkhtHWlA0Nv83otih+iWpJtn+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEeFL5Rj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so3748026a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713162807; x=1713767607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcK6IuttindIK0ibbk1Eks/0diZZJiqcDdWxbvTVosU=;
        b=AEeFL5Rj/WOd47L9xps5Ied29pZzRsk72wqqr6IFLkuXs+MPK1Pz0uw2Kzv3pXqepJ
         PQM/HSzuuyekS4psRRNZJSyO6Vv/ZbuntMgMmM4xfEofAlEycG4FzVwsqCLpzYCC98AS
         6xAkuaT961XCzwjG1pdBlKPqpz+S3wgOzXKv/s1EIq1WexeoTCLG0XHkHTfsZlvikQlJ
         CzRkck0xE5nFHijiW4zzlRm2Dg5Uv/KXBakMIbKzfZm4Ee3tib2TMWa7KebpGbuAjX/s
         5GlTpJ90oYbhNvu+SbMe9jMGa8xQSQQdqTjeq67Fvpp6jibsV2wTimKO2fCWbJwYJ9oi
         RZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162807; x=1713767607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcK6IuttindIK0ibbk1Eks/0diZZJiqcDdWxbvTVosU=;
        b=N/HLvwr9CduMtq9Mf431zK7KbAsDgg8h+uOOAR6AseerNC+cW+1zyFajYs8lwMY3vG
         vbGzcqv1yTyQi8PSRWgbsGHvldd9uTfAN7APVxNXA+SZ/QS3JRni0lXXGU+OBMod4dsb
         u6M5ldgPPtV2nvhXAVtTQ4W4f9J06r9dHUGGqbJCDcOFgVLqFOgvyJhaLk/8Hp1+mDtB
         htG1si0i79PApVtJjlKl3MBWQRzekJDCNQrA047zMdZ+RguTeTHpYBmm5pUVnzujt394
         a9PaL843apjn8UtRYIEPkPp/xtq8VTV8EGDWPuPzUwGDhGqbcNsWicy1MS8BhdST7xgL
         oEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIGLBTNrVLJhib6k9XBOapNgPjfpQWeRIyThnTlUOdLgfi9qCio585UjVJ7EUb9N4FOg5bhv8Z2Rcpn3dEe5XcfFG9FwtTGP9m1dnd
X-Gm-Message-State: AOJu0YzAuZpvyhTnsifBgvYpEcZcphXu4JAJAcdK/EayTs2lhdmJw+wa
	l25ZWuJvbY4Aj+iB+sjPuEQpCa/Eh1DCiBLpdSbwN1hmGFtyKXJvJWsUy38zGs4=
X-Google-Smtp-Source: AGHT+IGvpMtw3rMInVwgGIn+k3i/tzXT0C81uzRme6mL6qXm7+7PCc3jMvdKuafc3RxvzZ5W19cVzQ==
X-Received: by 2002:a50:8acf:0:b0:56b:fd17:3522 with SMTP id k15-20020a508acf000000b0056bfd173522mr5621220edk.14.1713162806745;
        Sun, 14 Apr 2024 23:33:26 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u5-20020aa7d985000000b0057000a2cb5bsm3225234eds.18.2024.04.14.23.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 23:33:26 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:33:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linan666@huaweicloud.com
Cc: richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2] ubi: block: fix memleak in ubiblock_create()
Message-ID: <79703e8b-ce3a-4407-9750-05f9202039d4@moroto.mountain>
References: <20231208074629.1656356-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208074629.1656356-1-linan666@huaweicloud.com>

On Fri, Dec 08, 2023 at 03:46:29PM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> If idr_alloc() fails, dev->gd will be put after goto out_cleanup_disk in
> ubiblock_create(), but dev->gd has not been assigned yet at this time, and
> 'gd' will not be put anymore. Fix it by putting 'gd' directly.
> 

There is another invalid reference to dev->gd if blk_mq_alloc_tag_set()
fails.

	dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
                            ^^^^^^^

regards,
dan carpenter


