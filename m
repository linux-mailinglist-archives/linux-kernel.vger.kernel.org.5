Return-Path: <linux-kernel+bounces-101372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D17587A630
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47316282E43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D603D548;
	Wed, 13 Mar 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPkOCJKW"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A13D3B1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327382; cv=none; b=Vi1RXoXg8xzX5a2FPGhnN30fzvgX+BJFCTLW+ez65g5YjdWXYRgOgkOATf7g3T7DcX0ls3//JJQsQXM2dhmBhk1UF4Jg8hOkt12METqwGjkVx4isRFl6TEkKEW51D/msrJgusg09VwhnAt4frnD+SXxTYuwbTRVTCNrFvBXWFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327382; c=relaxed/simple;
	bh=eo6Olp6DkFH1hTS08SAUUTwMlw8ID8eXArpvrsF8OQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Chjp/sTc37J8zlEKHGyUv4WTxPaIFf09csA/z7NqwzRzHuSbSipncgkW8rDi59AlJ9c1Hz4ou0iAVdP3jQ3N5r5NpDN+qdfIyuK4R4UtxSrq175KfE39w7LU0NwJQUuNnBGFu6A2TPastsZ462gcHH+kawCrOekGttrLUrzgDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPkOCJKW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46644fee93so24927866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710327379; x=1710932179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kp1Qu7oS00nm2b4G6O+KsRITn8FkEaWnzYBogvV+lq0=;
        b=zPkOCJKWOuCK0a0Ruar9qG3iUjn8WA1+hraT7EKzotuStGtdLVjXeIqItdgUox71yT
         xP5wHlfYSVWlfE1AQlxaIb31/+OTYT4rhsAXUfXYJ3MimRLYU+1BmE4bi76uPBj6sqne
         WLxDMqDwyJKNraOEU/G7hhsJx38vjw84seaquUiM/qnLDbT5nCQMQgFh5HHSqMJ+AtUj
         vh8zSzqcOLUjoNgThqLba8bHl+wwCfTESARcE3kl04woyykHWZLkcZYk54MMGu+wLitW
         wbln23l3cVmxFRoJZ7VnCzq2jtSpafmP0rGY5FAtrli0neXHqEZAkNgOezjM6xAwe6VD
         QAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327379; x=1710932179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp1Qu7oS00nm2b4G6O+KsRITn8FkEaWnzYBogvV+lq0=;
        b=NN5tKROOu/NwhALJBg0eA48XR9H60WWQIgoT4Nw0jbbBJ0fYVhywVw5s2X1rqg9guQ
         4knbEmNTEXjtQsNTaKKOAupQSYTSPzidFlBssdn8VPKtbrHsW6xygkO8tpXiWFQa+lhT
         xPc+QboaNBg1nN8LAM5uv8AqtNUi3NpVGsErqR27hWHbs2NKFnTwVRMKv5JS3l5E8Qtx
         IAO7ySMiaLDTWF3Keh/9L9XWgjJGINa/QU1Rx/5gTozFzqaKPLTR0FPBEfGb+DYNlIUD
         MQwfdZiyGoNh0pYyaXYkDSpMyvsOuJudIauTSv6PNkBld86d47pvFKV3N/XqO3N5/zaS
         uFyg==
X-Forwarded-Encrypted: i=1; AJvYcCUrHn04vGZG1IqD6TPuOEGjX5nN0FC18fV14cASAm2nt5v+hJleZb9Z2kSCaED+w3CrrUG8LP/x7VGeoMc7CCh2rQPWPEVWj9RM78Hg
X-Gm-Message-State: AOJu0Ywe/6Y4sBbl8pGLV2U4kTs2MmccuNaLS1KsGHWERjdCkTT6XWJt
	a+2bjBJMrBY6h9HQ4/GOe6aZgWFN9w2MNpRrYXdvGISjaIC7kyNYpdfZbcLJRq8=
X-Google-Smtp-Source: AGHT+IFcWQ2Zi/DdKucg2E3du26n6+4lKJjQpV7nddGbL5B8Yf4ZoRT91X84suPdCHuI9Iug7G35gg==
X-Received: by 2002:a17:906:6815:b0:a45:98f3:997e with SMTP id k21-20020a170906681500b00a4598f3997emr7285651ejr.7.1710327379218;
        Wed, 13 Mar 2024 03:56:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n18-20020a1709061d1200b00a46478fbbbesm1368893ejh.153.2024.03.13.03.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:56:19 -0700 (PDT)
Date: Wed, 13 Mar 2024 13:56:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v6] staging: rtl8712: rename tmpVal to avg_val
Message-ID: <b2044a45-e46b-4215-9494-4864cd0e7eb5@moroto.mountain>
References: <ZfF+qu+CGHlpHrtY@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfF+qu+CGHlpHrtY@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Wed, Mar 13, 2024 at 03:53:38PM +0530, Ayush Tiwari wrote:
> Rename tmpVal to avg_val in process_link_qual() to reflect the intended use of
> the variable and conform to the kernel coding style.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


