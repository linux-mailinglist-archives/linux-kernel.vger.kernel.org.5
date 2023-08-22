Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B10B783891
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjHVDdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjHVDdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:33:23 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E233C186
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:33:20 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1692675197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTs14t3rJwjJ8nQIqP8mM2RUjVXGIHh5DU3GMM4wEaM=;
        b=m8iZiLA5iTjxOVO6RAvgVGnFLhqNo4J7Kd+gqBuuDLHBH/K+T6EukywHTGnK+98TFwUIbL
        OWXj3gSGR+IlKlUKPydmO9miicRfd0NGDuB9Q5TrkJzisacFjXoS2Q/KIEoXse66lX2f8x
        dyCh+y0OTbVKkm9Ms/jPERaYR5AKz2k=
Date:   Tue, 22 Aug 2023 03:33:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <5c5de3dee5e5fcc4fbdf80226f0697f6269c585f@rjp.ie>
TLS-Required: No
Subject: Re: [PATCH v2] tpm: Don't make vendor check required for probe
To:     "Mario Limonciello" <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ps@pks.im, rjgolo@gmail.com, todd.e.brandt@intel.com
In-Reply-To: <20230821140230.1168-1-mario.limonciello@amd.com>
References: <20230821140230.1168-1-mario.limonciello@amd.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thanks for the patch. I applied v2 to linux v6.4.11 and it resolves the
issue on my workstation with the intel ADL fTPM.

Tested-By: Ronan Pigott <ronan@rjp.ie>

Cheers,
Ronan
