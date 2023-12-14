Return-Path: <linux-kernel+bounces-35-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E966D813B06
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A478C283E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A26A321;
	Thu, 14 Dec 2023 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC1RKIcW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779576AB94
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5d226f51f71so82864267b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702583500; x=1703188300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=py5AtU6IiNQuiEIbKIantmK9zZWdYzAGimVPNBH/TAU=;
        b=FC1RKIcW2gg5NUFt0rhoHLKtT5qOjN1rDPLQH/xJW2JwUW1MwWis5M/hDO9NyXMPaq
         XXLR7by8siNbi3jtvYC6hHisSIIYCX3U4mTFGE8jDHUWDNxsETcnn2EII/Hh2b0rm2Na
         QfoZSh6bz17w0yZPJvzWRlFxb8JxZDeiq+9+gmv0IaSBwrQG/8ymJ0P+e8WXHBaJoj+7
         ShxYr4EBvhPe+WflYg9ip4DD0jgA1Bz3X5Npi4RuZ7JU6SK4nNNH/McNAbwhlt/uiODl
         uzT4tjR8mMn75+IU2wQUaKbViZs32qG9AcfZ5BjX7iJL5RqtO3eK7CN5osbykbSUxj2P
         ptXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583500; x=1703188300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py5AtU6IiNQuiEIbKIantmK9zZWdYzAGimVPNBH/TAU=;
        b=T/4EEG+GmxXlo452q6HHuL5iQBeeXOaRGuy3jwXEffgsIbm3KE4qFzHBXirV06oxqZ
         /bEZqFVU2EYRfwf1aoZ3A16hLv2B9zymXqWCIB5OFAj+oV36dxKF7tUSay7DJIBRmnFy
         y1eDeemikyRqP7S1RgxONSqo3OpilwvRSaLG9hjHcNbDld8AGBlgXiQmj4wf2UjRneS+
         KqXiJtI5fyHd+sJY4YdjvSkSCg8/jm42o8dyc9zTG/1E7CDwPG2PjeR6BffoqH6YhHBQ
         jbWw2L2F5fohtsRk5ZuzGWmmmnxiD5brQ/Ggl2zOIK8JAIQG00gN6O/oCx59CcWQ2oiL
         Y4Sw==
X-Gm-Message-State: AOJu0YwUfm2qL9UJrPZiBXsigiaDJWAFSBfHyT2ive/NpaUKQyzD5oW9
	mMaNFSkACM19yS03e9RmsJM=
X-Google-Smtp-Source: AGHT+IG2XB5YH2zsl6qLwv5Pty1Gh0aJ9YjnvP4rnAfXv13He8R4Ot836fs8UeivdU7dXZtaZczKsQ==
X-Received: by 2002:a0d:cb01:0:b0:5e2:b8:5c9f with SMTP id n1-20020a0dcb01000000b005e200b85c9fmr4360626ywd.27.1702583500011;
        Thu, 14 Dec 2023 11:51:40 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e177:373d:4717:ff6c])
        by smtp.gmail.com with ESMTPSA id c128-20020a0df386000000b005d395bf0ad5sm5668155ywf.64.2023.12.14.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:51:39 -0800 (PST)
Date: Thu, 14 Dec 2023 11:51:38 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Potapenko <glider@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
	andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, eugenis@google.com,
	syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v10-mte 3/7] lib/test_bitmap: use pr_info() for non-error
 messages
Message-ID: <ZXtcytNpfG9NSL7z@yury-ThinkPad>
References: <20231214110639.2294687-1-glider@google.com>
 <20231214110639.2294687-4-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214110639.2294687-4-glider@google.com>

On Thu, Dec 14, 2023 at 12:06:35PM +0100, Alexander Potapenko wrote:
> pr_err() messages may be treated as errors by some log readers, so let
> us only use them for test failures. For non-error messages, replace them
> with pr_info().
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Yury Norov <yury.norov@gmail.com>

