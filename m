Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E815679160C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjIDLIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjIDLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:08:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD61A8;
        Mon,  4 Sep 2023 04:08:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so1080098b3a.1;
        Mon, 04 Sep 2023 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693825681; x=1694430481; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGFV9RdXIBN+D6ZdfrgNJVd3fOxwTgeaUelyWOQ2VLY=;
        b=P4HHYwe/lGYUHUcIo7rzodEvZICEtwk+0Ph1c3fzHY6TvTHOnYGsM4D9sFYlGXCjua
         uXqHkP5jUzYtwQguzt+e31tuIxxYv9PuHByLWjhMdbKYn6p/oblIqvz0r/ssttMLRyzB
         vhePK8UYSLgk1K6XzkbcL0ZVRKEqAo+k4hWwjmY1eRI2210xtOPDEEBEfPx57/t9lmTg
         aTzGrVAqu4xhN0w4DogwiDoRir2VPiZK2RJHwBlgE/IJ7t9WG4tmf8Y+nNdVkck8br+U
         1+XJHveDhjh44PmPJsv4US2NeMQp/jWowTdFdUbp6KvJiJeCx7NXrwB3KmlqKDVaM1Kf
         Dypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693825681; x=1694430481;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vGFV9RdXIBN+D6ZdfrgNJVd3fOxwTgeaUelyWOQ2VLY=;
        b=if3Sz0dsPhb+drOBxpX/TNPbawx61BIRNZ4hK2A8AEhcsp5cIHRvGdu+wTA8ecsjDE
         CrXpfM81Ko9/ALvVuymf+nAfCBxkUW8Aei+RxDpmYC9m6TXQ9ulmTUZt2A96VzT/DFpr
         zzqebWzN0i6onEFBMV1TKmXc0c813WKQRTE8JS2iqwZqgNM6p/1zWxmgD6yOnNkzvxri
         Buc0h60oyA0ZMio07rFjpgiZ8zPDpIH+mzsa9LHzkhb35eo/uNgU918Slsy+1gg8H6Xc
         pOZsuqR7eCrspPcOb88VX8gbHQCaHvZvvdA/uFMiLBEK0I+0TBLsMzfZ2haYF/Msw7xV
         wVrA==
X-Gm-Message-State: AOJu0Yy+UCAC4egg8Uvahbp7JiLlNhsIDXCR7UGtLLZeQCERRu3/sgAW
        hTH+StuhBkKpqyQUbghsPAk=
X-Google-Smtp-Source: AGHT+IGSm6XZ2nlG25arT69VYYhZ7sC3wwO1vhYk8pWlyzLHNDl72ZVoXTbaPcZuHWIZviCz6S9daQ==
X-Received: by 2002:a05:6a00:1585:b0:68c:3ef6:2170 with SMTP id u5-20020a056a00158500b0068c3ef62170mr12481566pfk.34.1693825680516;
        Mon, 04 Sep 2023 04:08:00 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id p22-20020a62ab16000000b006870721fcc5sm7396453pff.175.2023.09.04.04.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 04:07:59 -0700 (PDT)
Message-ID: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Date:   Mon, 4 Sep 2023 18:07:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Claudio Sampaio <patola@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Stable <stable@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I bought a new 4 TB Lexar NM790 and I was using kernel 6.3.13 at the time. It wasn't recognized, with these messages in dmesg:
> 
> [ 358.950147] nvme nvme0: pci function 0000:06:00.0
> [ 358.958327] nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
> 
> My other NVMe appears correctly in the nvme list though.
> 
> 
> So I tried using other kernels I had installed at the time: 6.3.7, 6.4.10, 6.5.0rc6, 6.5.0, 6.5.1 and none of these recognized the disk.
> I installed the 6.1.50 lts kernel from arch repositories (I can compile my own too if this would be an issue) and then the device was correctly recognized:
> 
> [    4.654613] nvme 0000:06:00.0: platform quirk: setting simple suspend
> [    4.654632] nvme nvme0: pci function 0000:06:00.0
> [    4.667290] nvme nvme0: allocated 40 MiB host memory buffer.
> [    4.709473] nvme nvme0: 16/0/0 default/read/poll queues
> 
> And then it appears alongside the other nvme:
> [15:58] [6836] [patola@risadinha patola]% sudo nvme list
> Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
> --------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
> /dev/nvme1n1          /dev/ng1n1            2K36292CEKD9         XPG GAMMIX S11 Pro                       0x1          1.39  TB /   2.05  TB    512   B +  0 B   42B4S9NA
> /dev/nvme0n1          /dev/ng0n1            NF9755R000057P2202   Lexar SSD NM790 4TB                      0x1          4.10  TB /   4.10  TB    512   B +  0 B   12237   
> 
> And I was able to read and write from it, pvcreate and so on, so it's working. But I can't use a higher kernel version so apparently this is a regression.
> 
> There are other people with the same NVMe model (although different capacities) reporting the same issue on this reddit thread: https://www.reddit.com/r/archlinux/comments/15xbxeo/nvme_device_not_ready_aborting_initialisation/
> 
> I am not sure but I think this issue might've been introducted after this patch: https://bugzilla.kernel.org/show_bug.cgi?id=215742

See Bugzilla for the full thread and proposed quirk fix.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.1.50..v6.3.13 https://bugzilla.kernel.org/show_bug.cgi?id=217863
#regzbot link: https://www.reddit.com/r/archlinux/comments/15xbxeo/nvme_device_not_ready_aborting_initialisation/

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217863

-- 
An old man doll... just what I always wanted! - Clara
