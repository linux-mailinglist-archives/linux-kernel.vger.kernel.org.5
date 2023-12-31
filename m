Return-Path: <linux-kernel+bounces-13773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CBC820C5A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 19:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997571F21538
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDBB9442;
	Sun, 31 Dec 2023 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXs9Dh37"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236F8F57;
	Sun, 31 Dec 2023 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-35fd9e40039so44558075ab.1;
        Sun, 31 Dec 2023 10:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704046278; x=1704651078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkS6xSdSRoL4hgkn+yQprbg+2tW+1a/M1t+s2IfgWqs=;
        b=WXs9Dh37WpnMCuamfhLlIrZlrCMkHiIs6nEHCDgXrkZON1BYWic3OIMs0MsytqHinH
         9WZYPc6lTrYIYdYyu8U/gPcX0I/2T2tN5jjWhGqR6MpQr+wk3YG3zuiR4eR8Tq+wbxjw
         klxbrAXCsxvHNIYkg9pDZ2VteE+8l5RSSNA0KJ/2k8nKkcXBf8ONMkIr1uX8n/RTB800
         25ByYo60wzb2s0v4acEGsJCfYvZ850tfELcg8goy1D1R8KSIYC8zqGgKlW9/cyGdaWvr
         auYzhceBUW9wgmoBpZ/8Uzs7vpNl0Juejh92hN5yUGnAk4vVUYTIFC7gWDeQUzMZjmRD
         vAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704046278; x=1704651078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkS6xSdSRoL4hgkn+yQprbg+2tW+1a/M1t+s2IfgWqs=;
        b=VHaiqstYtXc+6e+G3OsHAjwPgMQ7AW4tbrz4MkYE2uhxCQstGtcOHLkDyzwRJqnfx9
         iEO/HgkEcvCLuEONASAqjIFGTJqOYQriPnZab2VMT5UO0OTNmPzVzlkjxVeIusMbTOkw
         9gIpXkvVEZiXwfBRJ3n/wl0U3oAm7dvDDyDosXldMRaWlbONdfxC1M8P8UW2aCe3JhVf
         GcngMPGG4oO8ZVy8YQWjTP/DyQuQZibm911yzTy7PZAuMlZ7rWrSu/iZ+uXlwSETrTrR
         Ijo6IDBNYcwMpSVqAgGg+j9Spazuwu4XgSzudaoGGvR5pDequif2XCfymb2TEp51lcBv
         tNGw==
X-Gm-Message-State: AOJu0YzuQyI2we7trcN3qsl2gv6nZFwL68xFz932qUWkzsJt6VccMzgy
	9RffKlc7u3YqP4Myweh12y5ry0GjcNo=
X-Google-Smtp-Source: AGHT+IHSqh/K8sz5+BHmZsyiUJDnFyUKt786+fVsFRZCRQhpZNw1JJJIN3unbvfQ0zgJOHftDGm7Lw==
X-Received: by 2002:a05:6e02:32c5:b0:35f:ff56:c0fd with SMTP id bl5-20020a056e0232c500b0035fff56c0fdmr21977604ilb.14.1704046278522;
        Sun, 31 Dec 2023 10:11:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b001d4898862cesm6971868pls.211.2023.12.31.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 10:11:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Dec 2023 10:11:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (lm75) remove now-unused include
Message-ID: <e0aa8b5a-166f-4932-b84c-f3e901e01aca@roeck-us.net>
References: <20231228-hwmon-cleanup-include-v1-1-e36f65aee1f0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228-hwmon-cleanup-include-v1-1-e36f65aee1f0@bootlin.com>

On Thu, Dec 28, 2023 at 05:27:16PM +0100, Luca Ceresoli wrote:
> Including hwmon-sysfs.h is not needed since sysfs code got removed from
> this file in commit 08b024338166 ("hwmon: (lm75) Convert to use new hwmon
> registration API").
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Applied.

Thanks,
Guenter

