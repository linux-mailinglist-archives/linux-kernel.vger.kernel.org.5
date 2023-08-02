Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C58376DBD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjHBXuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHBXuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:50:13 -0400
X-Greylist: delayed 11023 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 16:50:12 PDT
Received: from 16.mo581.mail-out.ovh.net (16.mo581.mail-out.ovh.net [46.105.72.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07776F2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 16:50:11 -0700 (PDT)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.143.79])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id C959823B5A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:10:47 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-rgjtr (unknown [10.108.1.53])
        by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5614D1FD23;
        Wed,  2 Aug 2023 20:10:44 +0000 (UTC)
Received: from etezian.org ([37.59.142.102])
        by ghost-submission-6684bf9d7b-rgjtr with ESMTPSA
        id JSIlNES4ymQbxAMA7H/ACQ
        (envelope-from <andi@etezian.org>); Wed, 02 Aug 2023 20:10:44 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-102R004877e9143-2956-403d-937c-f8204c3860c5,
                    0C641BB37B7CC30D107EA61C426C60CA54BC1A77) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.172.51
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Feng Liu <feliu@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove PM #ifdef guards to fix i2c driver
Date:   Wed,  2 Aug 2023 22:10:30 +0200
Message-Id: <169100562782.1919254.11158822384469813603.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230801105846.3708252-1-arnd@kernel.org>
References: <20230801105846.3708252-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13278582028312513243
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrkedtgdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepveevieffieefgfefuddvteelffeuhfelffejteejuddvveekveehvdejgeefteevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpudejkedrvdefkedrudejvddrhedupdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorghnughisegvthgviihirghnrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 01 Aug 2023 12:58:15 +0200, Arnd Bergmann wrote:
> A cleanup in the virtio i2c caused a build failure:
> 
> drivers/i2c/busses/i2c-virtio.c:270:10: error: 'struct virtio_driver' has no member named 'freeze'
> drivers/i2c/busses/i2c-virtio.c:271:10: error: 'struct virtio_driver' has no member named 'restore'
> 
> Change the structure definition to allow this cleanup to
> be applied everywhere.
> 
> [...]

Applied to i2c/andi-for-next on

https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Please note that this patch may still undergo further evaluation
and the final decision will be made in collaboration with
Wolfram.

Thank you,
Andi

Patches applied
===============
[1/1] virtio: Remove PM #ifdef guards to fix i2c driver
      commit: 37097e6ffd22bb9ec0d87dfe5c6c3eec4d5b5421
