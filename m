Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4637D2DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjJWJKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjJWJKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:10:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213910CF;
        Mon, 23 Oct 2023 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=I9prQxPgmyE3xzWAyIMSdW1KLEhS2tX5PuKRMEYdlRA=;
        t=1698052209; x=1699261809; b=e2YcLTUOka0p0YqRhSUXztdiwOYkcBVZ7InN4eXMV6N9Cc/
        qJo+pPv9eDnMqAMcc74m3N/be9JORD66FAKb8sifBhQitFTh4hDzRDhoskrjfsrYSk/t2MLlREsPw
        wkWlsEBKASHN2mqh+YcuycN/hkznBbJOvX4B/5IlRQyl1zIFaP/j4A/xzfO0oah3isvpmop8wNeO5
        a4IpnxUI99TjY3E1FybYjG5gTiYoXGRlJflMWI/2QBxEVt5uyMIubwZSaSvmnNg7I8j/VI1c4nmNt
        y+tWaqfqZ2osZS3MHSUYHhh7SaUrD2x/LNs1UY64ChCtR9IJZJCpF5ptmMIoGttw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1quqwn-00000000BFA-3xSN;
        Mon, 23 Oct 2023 11:10:06 +0200
Message-ID: <433af526223619beabad96a9003cad05c5b6189b.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: Add check for kmemdup
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>, Chen Ni <nichen@iscas.ac.cn>
Cc:     gregory.greenman@intel.com, mukesh.sisodiya@intel.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 Oct 2023 11:10:04 +0200
In-Reply-To: <87zg09zowv.fsf@kernel.org>
References: <20231023064501.274599-1-nichen@iscas.ac.cn>
         <87zg09zowv.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 12:08 +0300, Kalle Valo wrote:
> Chen Ni <nichen@iscas.ac.cn> writes:
>=20
> > Since the kmemdup may return NULL pointer,
> > it should be better to add check for the return value
> > in order to avoid NULL pointer dereference.
> >=20
> > Fixes: 5e31b3df86ec ("wifi: iwlwifi: dbg: print pc register data once
> > fw dump occurred")
>=20
> The fixes tag should be in one line.
>=20

It's also irrelevant because (a) the fix is incorrect, and (b) we
already have a (correct) fix :)

johannes
