Return-Path: <linux-kernel+bounces-11322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7AE81E48D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ACA0B21B65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49E1EDD;
	Tue, 26 Dec 2023 02:30:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE27641;
	Tue, 26 Dec 2023 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VzFsMjM_1703557804;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0VzFsMjM_1703557804)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 10:30:04 +0800
Date: Tue, 26 Dec 2023 10:30:04 +0800
From: Wu Zongyong <wuzongyong@linux.alibaba.com>
To: alex.williamson@redhat.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	wutu.xq2@linux.alibaba.com
Subject: [Question] Is it must for vfio-mdev parent driver to implement a
 pci-compliant configuration r/w interface
Message-ID: <ZYo6rITis9siz2Av@wuzongyong-alibaba>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

For vfio, I know there are two method to get region size:
  1. VFIO_DEVICE_GET_REGION_INFO ioctl
  2. write a value of all 1's to the bar register of vfio-device fd
    and then read the value back which is described in pci spec

Now I am curious about is it a must for a vfio-mdev parent driver to
implement the method 2? Or it is just a optional interface.

Thanks,
Wu Zongyong



