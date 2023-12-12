Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF980F173
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377155AbjLLPrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377023AbjLLPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:47:33 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BE3399;
        Tue, 12 Dec 2023 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IpOE+
        yOb38TYE+chSPo0EQBJbqg59f0ue3S/ECPEw9U=; b=jQC4uwFCJwe0bL3XkN72E
        ziI6IK1+bbbz9d9kzqM7EMZrtWb0qwEQegRnG/LyiDekJLieLdWotkVm6qsTjYwZ
        BGuIhi+yjmMHQ97Bim+CEyMCicKhGflFEE1158o+dltNDZAuAsBU/cw1IETmMdu7
        dPko4gHA5W+Hz7aS4K+VuY=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
        by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3n0KHgHhly6dkBA--.31946S2;
        Tue, 12 Dec 2023 23:47:20 +0800 (CST)
From:   chenguanxi11234@163.com
To:     rafael@kernel.org
Cc:     chen.haonan2@zte.com.cn, chenguanxi11234@163.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH linux-next] kernel/power: Use kmap_local_page() in snapshot.c
Date:   Tue, 12 Dec 2023 23:47:19 +0800
Message-Id: <20231212154719.2667-1-chenguanxi11234@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0gLswRMBR1-b_TQTau7KMpuBbR5hYJyat6pMOD5zYSi7Q@mail.gmail.com>
References: <CAJZ5v0gLswRMBR1-b_TQTau7KMpuBbR5hYJyat6pMOD5zYSi7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3n0KHgHhly6dkBA--.31946S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RG38nDUUUU
X-Originating-IP: [117.176.219.50]
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/1tbiDglE+mSAZJK76AAAs4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your explanation, I have modified my description 
information and submitted the updated version of patch.

