Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE927F27CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjKUIqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKUIq3 (ORCPT
        <rfc822;linux-kernel+unsubscribe@vger.kernel.org>);
        Tue, 21 Nov 2023 03:46:29 -0500
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 00:46:22 PST
Received: from mail2.eciceron.com (mail2.eciceron.com [194.132.32.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D68BD
        for <linux-kernel+unsubscribe@vger.kernel.org>; Tue, 21 Nov 2023 00:46:22 -0800 (PST)
Received: from mail2.eciceron.com (localhost [127.0.0.1])
        by mail2.eciceron.com (Postfix) with ESMTP id 4SZHqr0rSlz4yPF2
        for <linux-kernel+unsubscribe@vger.kernel.org>; Tue, 21 Nov 2023 09:39:52 +0100 (CET)
Authentication-Results: mail2.eciceron.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=exe.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=exe.se; h=
        content-transfer-encoding:content-type:from:to:content-language
        :user-agent:mime-version:date:message-id; s=dkim; t=1700555991;
         x=1703147992; bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=; b=
        TbAtguYFBZRdoqqvQwqCOnmPkpK5Nb8kVUKvJFsYPEY6cejHGv583ncG1q7XRXsA
        W8puugctzAelOkWqxBBGVZPG38b4m4nyaS3mQeNZYtQGVAf0fDPN5l/EoTDn2wCh
        GlcHZ7KXH8b5GAUiVM61xXVh3oI3gWO/Lz8mJctzFBGzQbowE+96WTIR4udMBpoh
        smkKcMmmNgmNCBCTGuvQg/H19MXFM1CXEj7127LK/sHaYDMbsKM8Cd7VuPakifmV
        uJvDafTq0s5xzEqqGeEsvjd8iQb+vDLtSGdKABr2oIDF9PTmTSyzfjuoHMQn3/88
        3tLnrla/Wy45dy8isvAfeQ==
X-Virus-Scanned: amavis at mail2.eciceron.com
Received: from mail2.eciceron.com ([127.0.0.1])
 by mail2.eciceron.com (mail2.eciceron.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ns8PA9KnoA-U for <linux-kernel+unsubscribe@vger.kernel.org>;
 Tue, 21 Nov 2023 09:39:51 +0100 (CET)
Received: from [192.168.3.201] (37-122-150-181.kund.ip-osteraker.se [37.122.150.181])
        by mail2.eciceron.com (Postfix) with ESMTPSA id 4SZHqq6Wpnz50Smq
        for <linux-kernel+unsubscribe@vger.kernel.org>; Tue, 21 Nov 2023 09:39:51 +0100 (CET)
Message-ID: <9cd641ea-c88d-459d-9bdb-f0c1c300e831@exe.se>
Date:   Tue, 21 Nov 2023 09:39:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-kernel+unsubscribe@vger.kernel.org
From:   Gulp <gulp@exe.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,EMPTY_MESSAGE,MISSING_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [194.132.32.24 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  1.8 MISSING_SUBJECT Missing Subject: header
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


