Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060A478071D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358575AbjHRIZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358647AbjHRIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:25:17 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 01:25:14 PDT
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E032A2684;
        Fri, 18 Aug 2023 01:25:13 -0700 (PDT)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6705042627;
        Fri, 18 Aug 2023 10:05:17 +0200 (CEST)
Message-ID: <1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com>
Date:   Fri, 18 Aug 2023 10:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
From:   Fiona Ebner <f.ebner@proxmox.com>
To:     linux-kernel@vger.kernel.org
Cc:     siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        jdelvare@suse.com, Guenter Roeck <linux@roeck-us.net>,
        netdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
        keescook@chromium.org
Subject: "Use slab_build_skb() instead" deprecation warning triggered by tg3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we've got a user report about the WARN_ONCE introduced by ce098da1497c
("skbuff: Introduce slab_build_skb()") [0]. The stack trace indicates
that the call comes from the tg3 module. While this is still kernel 6.2
and I can't verify that the issue is still there with newer kernels, I
don't see related changes in drivers/net/ethernet/broadcom/tg3.* after
ce098da1497c, so I thought I should let you know.

[0]: https://forum.proxmox.com/threads/132338/

Best Regards,
Fiona

