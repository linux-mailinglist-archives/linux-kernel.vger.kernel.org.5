Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5AE7E0979
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376681AbjKCTeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjKCTd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:33:56 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE371BD;
        Fri,  3 Nov 2023 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1699040026; bh=sFZn0NahGo+twcgbeOgB0GpkgC56iWuB39KBcaq2Kks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eJ4SRb6g134BOCaarbNbQicZ0+G38s29pUpYZG2CAPwcgF5pbVb3KwcP2RSW4EYLh
         nWhT0CaP2OocHTEFmAnrKGtkNH0i7ZmUOPujuGTW+jxaXIUHNK/cgP+XBQ84mcpbya
         irsIYfJPDRVUGh48HEf7D9fbg5syroQPZBWvwPs8=
Date:   Fri, 3 Nov 2023 20:33:45 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, sre@kernel.org,
        Shyam-sundar.S-k@amd.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Backport of commit "power: supply: core: Use
 blocking_notifier_call_chain to avoid RCU complaint")
Message-ID: <ff242a4c-8c84-485f-a100-0317eaa1544b@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913033233.602986-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear stable team,

I would like to propose the commit
bbaa6ffa5b6c ("power: supply: core: Use blocking_notifier_call_chain to avoid RCU complaint")
from mainline for inclusion into the stable kernels.

The commit fixes a RCU violation as indicated in its commit message.

Thanks,
Thomas
