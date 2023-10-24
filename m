Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C857D48DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjJXHqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjJXHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:46:12 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDEAB7;
        Tue, 24 Oct 2023 00:46:10 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1ea05b3f228so2809000fac.1;
        Tue, 24 Oct 2023 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698133568; x=1698738368; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crcJZphGqKpgNzGM6PW7RcwV7MNwfIsOtsxoD091HgM=;
        b=cwOprteZyXg5iXCp7OgBNBLUwTFOauEpELSbXZeZDSwG7WB1jPLYQ8KhfsAS84bTgR
         XEpu2zZYsEnA/VCCPEgS1yIvPr29ERwf3f4Zjt6d3fAIWXXcJzk1I5Pxj5ja5/J6jcfK
         Jt3w8s2QSB7CRboYl5Ymur7SWvQIEQUVMmGXLK/WZcW8Zdelsj1J4Ee9gfY3ZR1ybOWk
         NPpOs84by0p2uEo/EPDQyinfHqrpIXoG2xHdeJxWC5orzgjbTG1h3cHIjmiE7a4sqmeg
         WysMhctOTqRku2Mft4sZlFDHNnlvvoB83TRn6b1DJDaI+3sEiMVDLJ7kq7CUJxBZkLVM
         stCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698133568; x=1698738368;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=crcJZphGqKpgNzGM6PW7RcwV7MNwfIsOtsxoD091HgM=;
        b=Nr1waz9Io7c3kAXXFntTzoi1tfm29AL5wbjmMsW9LijxJzejmFn3TleklzOk5azBCE
         nDP9CfL/7jb1BVm1a+oc2+pqehsbw/F9yeozw8VwaHhPwmKVoueNxu/rZYlu3ln5Rpn9
         xP/CHBwzuYiD5dx5Bi7P4rffCIoQd/AvQwfIeDEmXlP9p9j+ZzFHK8Ksk4dvz7324mCN
         zONAI4HcoEGbSy+qEIVEjI5wNMlPLMiuRnD8OoFn7VC6S0Z9WAk2ZRyrAvYlEDJ2eyhG
         lZsv1cPY00WtMUCQWyL7KkiofPMmBcNVOLP1o7hM7nIWOuISM/944Navh2/qR4tfmrYR
         i9JQ==
X-Gm-Message-State: AOJu0YxgukLNTnuvFl/30qcCIPEj2VFU214QlSQUA/bgfVs24MCmyach
        N+CpI3fPXy7TNhFM7mVnF/TCt02QbBw=
X-Google-Smtp-Source: AGHT+IHs1W1HIW7R0G5ajbRXMxhWCNb3B71kf0w4STqGqwHr8J1UnDLhCIs4OXoOxenNuC5X5YiAAg==
X-Received: by 2002:a05:6870:1148:b0:1ea:eed:fd02 with SMTP id 8-20020a056870114800b001ea0eedfd02mr11468882oag.45.1698133568543;
        Tue, 24 Oct 2023 00:46:08 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id k67-20020a632446000000b005657495b03bsm6366509pgk.38.2023.10.24.00.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 00:46:07 -0700 (PDT)
Message-ID: <462c5ed5-d8ce-4862-b1e9-04787847b4a6@gmail.com>
Date:   Tue, 24 Oct 2023 14:45:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Block Devices <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai3@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, michallinuxstuff@gmail.com
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: queue/scheduler missing under nvmf block device
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Noticed that under 6.5.6 (Fedora build, 6.5.6-100.fc37.x86_64) the queue/scheduler attr is not visible under namespace block device connected over nvme-fabrics. 
> 
> # readlink -f /sys/block/nvme0n1
> /sys/devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1
> # grep . /sys/devices/virtual/nvme-subsystem/nvme-subsys0/*/transport
> /sys/devices/virtual/nvme-subsystem/nvme-subsys0/nvme0/transport:rdma
> /sys/devices/virtual/nvme-subsystem/nvme-subsys0/nvme1/transport:rdma
> # [[ -e /sys/block/nvme0n1/queue/scheduler ]] || echo oops
> oops
> 
> What's a bit confusing is that each of the ctrls attached to this subsystem also expose nvme*c*n1 device. These are marked as hidden under sysfs, hence not available as an actual block device (i.e. not present under /dev/). That said, these devices actually do have queue/scheduler attr available under sysfs.
> 
> # readlink -f /sys/block/nvme0*c*
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1
> /sys/devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1
> # readlink -f  /sys/block/nvme0*c*/queue/scheduler
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/queue/scheduler
> /sys/devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1/queue/scheduler
> # grep . /sys/block/nvme0*c*/queue/scheduler
> /sys/block/nvme0c0n1/queue/scheduler:[none] mq-deadline kyber bfq
> /sys/block/nvme0c1n1/queue/scheduler:[none] mq-deadline kyber bfq
> 
> 
> I have a little test infra which normally, after the nvmef got connected, would take the namespace device, set some sysfs attributes to specific values (that would include queue/scheduler) and then execute fio, targeting this namespace device.
> 
> The only clue I got is this https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d85ebf95c44e, but then again I am not sure what to make of it. Initially, my thought was "ok, queue/scheduler is gone, so just don't try to touch it". But if the c*n* devices still do have this attribute available, are they meant to be used instead of the actual namespace device, to tweak these specific sysfs attributes?
> 
> The problem here is that I have two c*n* devices but only single block device (multipath setup). Would that mean that changing either of those devices' attributes would affect the actual namespace device? Or is each path independent here?
> 
> Any hints would be appreciated. :)

See Bugzilla for the full thread.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218042

-- 
An old man doll... just what I always wanted! - Clara
