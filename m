Return-Path: <linux-kernel+bounces-106562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D34387F04F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4661C210B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F085674C;
	Mon, 18 Mar 2024 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fovl7Yyy"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747615645C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789492; cv=none; b=n47vf4dD3+beQ5OVgvMOG1BnVM4SydXkkcSaUsJpKtnqGR6fuQJqxkdMl248JvJbBoPR6LQlCIWqNh9eq4KhrpplPOGpWdfdzXFfue7apS8r4QitEy4/rJfmsYKvhpmnxfH9NyLHdMN6saSsGl+wtOe82mSBBNom9+FzJu2ym1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789492; c=relaxed/simple;
	bh=ytr//eYLa1X9g4yRUoGqc07iAQMxraS4lWr+6zqSZyM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t2A8dFlXFaaShlrAW3/daQkGlf0GWQh1X2i9jx0ICkdlsKYkdBDc7jglK/IDePUtAvimhXmeRLOq/PYZ8GmNABN2km8HiLdUa9DlD8wtxmmyAs/x3ygEJgCBNdlv0CR9LFedk38ZKQZ63ByfJbvOU3XIZfrgT2FNNEojP+ZzJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fovl7Yyy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-568107a9ff2so5694644a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710789489; x=1711394289; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytr//eYLa1X9g4yRUoGqc07iAQMxraS4lWr+6zqSZyM=;
        b=fovl7YyyCxMt/J43K61oUA9AmZyIpMsRQYXKLWfHEnw0Xupa5FshOWadNfMN5qFTns
         fJltBMLgpy18kemUeG/y2qaeozknoUsPOOQ8hYq835snJ2jolDdgZkHojaXmBNfmK/I1
         7DR+CXd8aIcQtxp2dHDAITU2RYH7WuRrKIhk2DAWVLODE7SKaNHfOM8nFAcHwAMulYUM
         XZK68FXRaFqsQcOcNL/Hbf5GpjC9JSLePzZ6lpoZYBrrp/GhabcTTtg0mveBQ/Fd9b/t
         ExKm+L44vfz3dEdP32K+XCJksJD14wRVIXU9Y7OerPh+G2Nb2FExYK4qeX/ilLHxQf/r
         HfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710789489; x=1711394289;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytr//eYLa1X9g4yRUoGqc07iAQMxraS4lWr+6zqSZyM=;
        b=MbArYQLJXI0suiCvTgnWPU3mkjRhR6Ba9wnU4CQ1RYFTK6erP00UPpyU0wbcT732Ak
         9AqurdstvBIj2duA30ta8gXnybEo+nDbpvbwpc4WXfvYeCSQNENtcNcJLHU+aen5sXYS
         bbyzAoj2qgjqg5pho3WRAiIWROVZcHOokBy7afAJnxwwqsiKy4iQlwW46BfHKorp/mOx
         EwwExWdDEbAALu9QRTkZMMNcjO6Dkuv09o9XxjGtOO9v00siIje0dYGsYCJpqtiIgGmR
         FSlfP7oOAeRUL4DFSRKF4Bam6cBPGVcPCUImkidebP5X9MhC9vtLafwKdOYfACGJF6Jz
         VLug==
X-Forwarded-Encrypted: i=1; AJvYcCW8VtdCK85wSFoC4qPfLWlG3S1YLmCqgaIfzY1+Ho9sgOGVnGjlab1k0z2AJG/1EG46ni44odviwDorr+m0deNsgEBMqVHzLm1IGEMY
X-Gm-Message-State: AOJu0YxHAvqXO1tjj8GvLxsdz6KovnBLrRRxKpwzGAs5yVDsYnL8CG/i
	8gqLJrYCEtDGsNnPC0cjyT2j0hASq65A5rqqyiv0ySARdBiDtumo5dZcIrkw
X-Google-Smtp-Source: AGHT+IHFNe/O+tX4h5VGoYJIzSrXl+++Oc4jJ+ncJl/8H9PT8sRcu+e+VkZBVlNdhHtYXHeVMAtjWw==
X-Received: by 2002:a05:6402:4290:b0:565:980d:5ba9 with SMTP id g16-20020a056402429000b00565980d5ba9mr7420101edc.32.1710789488644;
        Mon, 18 Mar 2024 12:18:08 -0700 (PDT)
Received: from mehdi-archlinux ([2a02:8109:aa27:2d00::e094])
        by smtp.gmail.com with ESMTPSA id ef6-20020a05640228c600b00568c2ea2cefsm2630438edb.51.2024.03.18.12.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:18:07 -0700 (PDT)
Date: Mon, 18 Mar 2024 20:18:05 +0100
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: tzimmermann@suse.de, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: drm/tiny: QUESTION: What to use instead of drm_simple_display_pipe ?
Message-ID: <ZfiTbYAa7qxXlrPd@mehdi-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone :)

I am implementing a tiny drm driver and I am currently working on the
V2: https://lore.kernel.org/dri-devel/cover.1701267411.git.mehdi.djait@bootlin.com/

I got a review on the v1 telling me not to use the
drm_simple_display_pipe. Can someone please explain this further ? Or
give me an example drm driver that does it the right way ?

--
Kind Regards
Mehdi Djait

