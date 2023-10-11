Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B67C4BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbjJKHVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbjJKHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:21:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA45A90
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:21:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-406402933edso60984675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697008902; x=1697613702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6onyuTNL+RmJpgqn0wTHaZliIp2waNtNht1K7VeUBDc=;
        b=thE4iAsDYize+mL1UvNPt1ZntGXSxSV/dD02cfMi8txjoNC1YIgJVjgAPm3kJ+NhkC
         o7d0zShW7t3tBtuMwXFohJki0kg+hcp3BNmbRV6bHYzWUDQXGLeH9Rt7pztdDh2AlpqY
         N/F9r3IqBU3m5XwqFDQVxYQo02uL0D3nC2cDw8szIzHKBG58jlrHOoDMTIfgyAJg4q95
         0A+XV+USC7s7Q8gX6FLpZzxSQ41DOc7Riv8Cc1zH86+szgC6hsg8xLsJ4/UuUqzKG6lc
         CIHklYpwhCBeYB8LkWWkUuvmsYPF1zWQYN8RzDKWmGOnNERQOn7ipaMuskjAvx2Dc0CW
         TEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697008902; x=1697613702;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6onyuTNL+RmJpgqn0wTHaZliIp2waNtNht1K7VeUBDc=;
        b=ugW4ZQYiL27RkvXn5pywEVIp1RgC2BpjV6iKEOSFQxmix0FFo+4PXbniVTJ2dqFajf
         1BLO7kKxlsMt/1PdR80sX7RKD4I0XOPj9z+NYFqrqw/Slf6jqVJZAKnnk2hfXwrGXCAD
         dPPaPISfk5rz7hNVqkNzG1w6RZarJ04ISFZnTRTGw8M0l8OthaMwhFos2YFrsbqvRIOc
         uYfv2jdPmQcLiOP6P6AyXRIFICnaEUv5f4aRVlV/o4g9FiDXPCmWfUbpj7Ob3bosC3FL
         hITo42s3yiyjoFwv0RbIhxS7lDw1OpqpHYU6b5U4ZpxEhDLV/ob1yK04HU45/D9U19Ri
         XSAw==
X-Gm-Message-State: AOJu0YxXumoaEzPPihAe69+Adu2P0MdEiitBhLkg8Zi4nnsvidJLoLf1
        EvWBkD1RxsHqBNriUJwnnBsyXB8JJkyHt8Cas5M=
X-Google-Smtp-Source: AGHT+IFi0HEIhpJot2aVjlAGP6vgnDPZnWhdXDPHCNl3BwzmCQdWMI2BF5LqMTM581Ttl410ZQHQjw==
X-Received: by 2002:a05:600c:22ce:b0:405:34e4:14e3 with SMTP id 14-20020a05600c22ce00b0040534e414e3mr16991755wmg.3.1697008902152;
        Wed, 11 Oct 2023 00:21:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c230b00b004053a6b8c41sm15869740wmo.12.2023.10.11.00.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 00:21:41 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:21:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn:
 variable dereferenced before check 'peer_device' (see line 587)
Message-ID: <fa10fbf8-d852-45bb-a631-d8dcb6697e16@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da drbd: Pass a peer device to the resync and online verify functions
config: x86_64-randconfig-161-20231003 (https://download.01.org/0day-ci/archive/20231011/202310111418.3EglIsGN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231011/202310111418.3EglIsGN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310111418.3EglIsGN-lkp@intel.com/

smatch warnings:
drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn: variable dereferenced before check 'peer_device' (see line 587)

vim +/peer_device +588 drivers/block/drbd/drbd_worker.c

0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  585  static int make_resync_request(struct drbd_peer_device *const peer_device, int cancel)
b411b3637fa71f Philipp Reisner      2009-09-25  586  {
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30 @587  	struct drbd_device *const device = peer_device->device;
                                                                                           ^^^^^^^^^^^^^^^^^^^^
Dereference

44a4d551846b8c Lars Ellenberg       2013-11-22 @588  	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
                                                                                                   ^^^^^^^^^^^
Previously we assumed this could be NULL

b411b3637fa71f Philipp Reisner      2009-09-25  589  	unsigned long bit;
b411b3637fa71f Philipp Reisner      2009-09-25  590  	sector_t sector;
155bd9d1abd604 Christoph Hellwig    2020-09-25  591  	const sector_t capacity = get_capacity(device->vdisk);
1816a2b47afae8 Lars Ellenberg       2010-11-11  592  	int max_bio_size;
e65f440d474d7d Lars Ellenberg       2010-11-05  593  	int number, rollback_i, size;
506afb6248af57 Lars Ellenberg       2014-01-31  594  	int align, requeue = 0;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

