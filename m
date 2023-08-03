Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F6C76E315
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjHCI3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjHCI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4E49CB;
        Thu,  3 Aug 2023 01:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B8CC61CBE;
        Thu,  3 Aug 2023 08:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F48C433C7;
        Thu,  3 Aug 2023 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691051144;
        bh=wMQy275Ol9CD0OwiDgSzpC7pNbHAeOO/DZdFPFRZAHc=;
        h=Date:Cc:Subject:From:To:From;
        b=da/JJ4n/Jsc0XqYYQFjVmcnFRESR6nXZ/NFZGLarcHZrtrdVFA27SUM+aY8VlcsBA
         d71TaWla8VDtMObdi2t39FFDxEb+kF/+S7cO9n6PIqvPOGTQrtISmiQRPV0IVuKbvt
         6M27xgmR21JEbl1bI94G/M6/d21qkWMiw9b/v2HompVeWuDe4VSu9NdqqYi6fZn7X0
         wObSKpfqB0orvjMEnVJ4duyw8MJHpFXaoXUoTo+1JMZyW15+df97M2X45xEXP7ChtX
         Ia/yQD2YHcSpaBTCn/RRoMTMRz0qzDurRRvMthomwSwO8p7G2CSOVIK3/kCr/SK9Vb
         Zv1mWl5sfl3iA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 03 Aug 2023 11:25:35 +0300
Message-Id: <CUIRLIY5N6CI.3O9UKOY2N5BS7@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Stefan Berger" <stefanb@linux.ibm.com>
Subject: 
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a working PoC for boot-time initialization of vtpm inside
tpm_vtpm_proxy. ATM, it uses the Linux firmware interface to load a ELF
binary for the vtpm, and delivers a communication end for the helper
process.

It is a great feature with the current narrow scope for continuous
integration. Obviously the scope could be later on extended to e.g.
from unencrypted plain text to a vTPM living inside SGX enclave.

I could send an RFC of this, if there is wider interest for the
topic.

BR, Jarkko


