Return-Path: <linux-kernel+bounces-101177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A550087A39A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF9C1F221C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F11171A6;
	Wed, 13 Mar 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCn6A1VD"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A3168A4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710315099; cv=none; b=kpu8m3tEd3t4JGJjDW90MDTFA02IbCQAjmfuybAHAti3V30IXKhvBnlRT02mj/PfFoVSlsyhumnZCkFw+vKNK2H2ldCirESv1NZy87MJZc3SgPXa2y3NQ8iLQ3VlhXeqJRrzha86FK0mk7y/Ft+cBPA4KuoCS8XNA+Zv6UKq/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710315099; c=relaxed/simple;
	bh=0ulPmN/6zRMPDefW45bWSkdaoWgY//u8/MxBvnfZAZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THGduBVl/HtsMu+GCZf6JIna4Ep/nSg/TsRpcWiTp6EEpsen/KIPHZC0jvlIO9qYvR9ZYWu+GcrT+Grm345gX5sAzupWZz5WJbNcMcjgWRqL9Vf/13CcPEXFNp2EJVH4jSCPFXwKiJNUfgmwQMxNOTLFO1/RlbXnKts1aMLnHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCn6A1VD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4429c556efso544625966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710315096; x=1710919896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOAwKQmgsPY1H4V2RUkh1YvtW25a6UVBaZMleLqQrNI=;
        b=CCn6A1VDr9enohBoMBNpS62zC8+DCN5G88jlMuaSiti9lacWWmmameashbneZEL3Uj
         JDDn7az+m+MhKrr5EOfWO7Wfx3/D72YbRMqnStrw4CZH2bE/bkD7XDYh3Zz2GBg07Fgr
         2QBNR73FQ4F6US98rcyPExeCsJ6xeTtCrCUyUKU+Hw2OQ8rAjKApeJJ1mUtytgvFHOiM
         bR7+X49RP/2e/9V+kSIU+AwnLAuTnyTOOWjrrCm4p24nZ7e2BhDuu4B21zOzDs67QvDn
         euDLLAaPb2cKzd433FS/43V+KhIqzzKCVPGvVpbcHuJTd/cUTk5THCURdY99bw6tB58Y
         epEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710315096; x=1710919896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOAwKQmgsPY1H4V2RUkh1YvtW25a6UVBaZMleLqQrNI=;
        b=kgVadkheabyhDYUgCQYyhueM2eLND1BILvEF3FdSIQcIhLcKTvlhuWPByX9PFPmFTB
         HoM95S3JL0HZrsgIFWt3spZcWwAleldgJh3YZ9tG1+9q0qcurqEbnVZvD6QWlII4vS7t
         PqcdTTgdP3S0LBDUj4q7fkWdZfLNickgEWVAplY9RzDmceUtdTDIKsTUIisBJEKBQb8b
         7j70adweH7d7mRJgNS03n+PgHlGuKYh/mzYbkqkuCEOSDmWj3pkBZsOHYQTelHoOIWpk
         KhcjrRuxaPdXkrDEu6aKlO4gS0clZDLFVxBwrlAtRbcwfHDGHJ4HQ6bK33nsbmcyG+XJ
         MyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU14TFbGKX7kIIgwgEW+XDf/B8NHGFJMtz6f354hb5kGaogaNV4oB0fxa1MNfJP9YgQf4vDCTQBnzH8hHu8e5/klWd4Q4X+qzMDZnc0
X-Gm-Message-State: AOJu0Yx2eIJvG43Kl+QBPRJ/Wn2nkMvlLNHhF0xbPfUsBoAlDAN8sWpQ
	u57jzZdyeBlAlVhIO0EEm1w2qJZww1i8jTF+VciRdEvDfFBTJEl3HIb3wQ2UszU=
X-Google-Smtp-Source: AGHT+IHCLRlF7VgwA/kF7PNDT1Xh0kGqxJO73kGaHCp1D8H3TRLSo6xlRZXbWd1uFRMKpky9B3cI4w==
X-Received: by 2002:a17:906:f156:b0:a46:4800:123e with SMTP id gw22-20020a170906f15600b00a464800123emr1501624ejb.73.1710315095706;
        Wed, 13 Mar 2024 00:31:35 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709067d5400b00a46224d4442sm3043466ejp.212.2024.03.13.00.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 00:31:35 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:31:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: rtl8712: rename tmpVal to avg_val
Message-ID: <7a84be06-e19f-4f60-ab94-7758d5df1ff3@moroto.mountain>
References: <ZfFSDoNPjQypC829@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfFSDoNPjQypC829@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Wed, Mar 13, 2024 at 12:43:18PM +0530, Ayush Tiwari wrote:
> Rename local variable tmpVal to avg_val in function process_link_qual
> to give intuitive meaning to variable and match the common kernel
> coding style.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> 
> Changes in v3: changed variable name tmpVal to avg_val
> Changes in v2: added a period in message

It's not an average, it's a percent.

regards,
dan carpenter


