Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2757F7A81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjKXRhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjKXRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:37:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E898F1718;
        Fri, 24 Nov 2023 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=aPWbKdwcZDf7/l7h1E2fzU2EX2i//JsMQ/TQX0MlYO8=;
        t=1700847440; x=1702057040; b=OYFFVmXUE7+r6q0y0ccj+Z3xYsVU6EL8677KJTKx2+r8HRQ
        cyMkPRfypnjiBGAu7liXyykTBOTUdfVJ77XGFi//YeCQskciFRbV3sMvGow98tsC0RQ5QzCcSKyVW
        DunLxBn7SzHrlxopQCIbBBAuonM2vsk6XriyZm/E2T4Az0Y4z4CEatt1e6BhUShsdpH4JlR0z+4hZ
        MINysVnrE6vfxx7fQLZLjFy56gkFLgvj1Ms+r2Bne2wKUe1+bDpO2iemPxNDW8cmtip+4q8jfLqG2
        dXp8y3ZN4hsjPR+iJSG7VCouGw2sxcEcl0WuwEeLsUlzSLom0CzkK2UQu3wxo/cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r6a79-00000002hHE-3BIc;
        Fri, 24 Nov 2023 18:37:16 +0100
Message-ID: <f0bebfe0f7e02bb51676d8f6a80be0444e2b8662.camel@sipsolutions.net>
Subject: Re: [PATCH] uapi: propagate __struct_group() attributes to the
 container union
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Kees Cook <keescook@chromium.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Will Deacon <will@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Date:   Fri, 24 Nov 2023 18:37:14 +0100
In-Reply-To: <20231120110607.98956-1-dmantipov@yandex.ru>
References: <20231120110607.98956-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-20 at 14:05 +0300, Dmitry Antipov wrote:
> Recently the kernel test robot has reported an ARM-specific BUILD_BUG_ON(=
)
> in an old and unmaintained wil6210 wireless driver.
>=20

Heh. I guess it wasn't unmaintained enough for someone to touch it and
add struct_group() to it...

>  include/uapi/linux/stddef.h | 2 +-
>=20

No idea what tree this should go through, but I guess wireless isn't
appropriate.

johannes
