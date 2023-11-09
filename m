Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FEB7E6CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjKIPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjKIPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:00:50 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F99D3588;
        Thu,  9 Nov 2023 07:00:45 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 7366918652F9;
        Thu,  9 Nov 2023 18:00:41 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YpPGjExAS4yP; Thu,  9 Nov 2023 18:00:41 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 1C7E518633F8;
        Thu,  9 Nov 2023 18:00:41 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ASjcS8G33HKl; Thu,  9 Nov 2023 18:00:41 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.14.192])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 91241186505E;
        Thu,  9 Nov 2023 18:00:39 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     stable@vger.kernel.org,
        "Greg Kroah-Hartman ." <gregkh@linuxfoundation.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        lvc-project@linuxtesting.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5.10/5.15 0/1] media: atomisp: add error checking to atomisp_create_pipes_stream()
Date:   Thu,  9 Nov 2023 18:00:00 +0300
Message-Id: <20231109150001.22891-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomisp_create_pipes_stream does not handle errors in
__create_pipes and __create_streams in versions 5.10
and 5.15. The following patch may fix it.

Found by Linux Verification Center (linuxtesting.org) with Svace.
