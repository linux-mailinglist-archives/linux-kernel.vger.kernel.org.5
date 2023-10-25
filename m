Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EE37D68B0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343621AbjJYKec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343589AbjJYKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A46BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698230017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sLw+xTXfry5r3/ti5ulvPxarMfCsTLFS8WTKCXQP2us=;
        b=IxP/tLAnwm5kSvmtj0/bOuotEpVuGiyhc3+XWUwrLSkEkwnwgRPSlp4zWOhWJy3t6zp2c1
        J+qkC2qD/SguVFbz0Dp5/dVcO4BqdwVuGP0XQXxegXoGzZdQ9i4oadtdgi2y1NDnQ3NN6f
        keOJf5YvErwonWq8TpqF6iwPKYWleSM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-M_ahc-PIPiGpIOmS0EWofg-1; Wed, 25 Oct 2023 06:33:17 -0400
X-MC-Unique: M_ahc-PIPiGpIOmS0EWofg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF36891F28;
        Wed, 25 Oct 2023 10:33:17 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1F971121320;
        Wed, 25 Oct 2023 10:33:15 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next 0/2] Remove VF MAC types and move helpers from i40e_type.h
Date:   Wed, 25 Oct 2023 12:33:13 +0200
Message-ID: <20231025103315.1149589-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series removes MAC types for VF functions and moves inline helper
functions from i40e_type.h to i40e_prototype.h

Ivan Vecera (2):
  i40e: Remove VF MAC types
  i40e: Move inline helpers to i40e_prototype.h

 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 +++-----
 .../net/ethernet/intel/i40e/i40e_prototype.h  | 70 +++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 76 -------------------
 3 files changed, 80 insertions(+), 99 deletions(-)

-- 
2.41.0

