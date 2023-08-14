Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6EC77BFCF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjHNS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjHNS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:28:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4243F171B;
        Mon, 14 Aug 2023 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FgCusAeBpy6xluPe2GxBfabcialAIc5NfedwcMC+0Dc=;
        t=1692037696; x=1693247296; b=bwLiQmJm4xufPLlvsz18C8z9H+KgzuckeDum54esgYBL5al
        Z9UTDkcXvVN4BL//zTpu3LM68P7B4JPFFdbNV+7SIuuXvTUUfv/OQfMBQcGicUwZX+1kfPDXPSota
        TDWxaqbhg03EMuHhfWQFWaM8zPrcg2l2+2Ups4LWPCO2wxtuFWf1Rq7Am3tc61IJzQexrmnYZZhhu
        RrnXPBC1RUfllLt13uYREY6NJm6BL7jABs9okyKoV7WpDzEgUZH160S1gUaKPYU5Ok1+e0+SfOxLx
        LSgj7dijxLep7lE7XwltIiamO2uZxJlUYi90t8q6Rh2gxd0g7IvukpW1cacCN9Kg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVcIR-007B24-0c;
        Mon, 14 Aug 2023 20:28:07 +0200
Message-ID: <9a6b2c18b599e5c2e7cea99fec84a4ecb5092da5.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: dbg_ini: fix structure packing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arnd Bergmann <arnd@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Aug 2023 20:28:06 +0200
In-Reply-To: <20230616090343.2454061-1-arnd@kernel.org>
References: <20230616090343.2454061-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-16 at 11:03 +0200, Arnd Bergmann wrote:
>=20
> As the original intention was apparently to make the entire structure
> unaligned, mark the innermost members the same way so the union
> becomes packed as well.

Hm. Not sure exactly what you mean by that, but shouldn't we make that
"union { ... } __packed"?

johannes

