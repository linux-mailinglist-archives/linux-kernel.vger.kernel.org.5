Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8DF7DE195
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbjKANJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343771AbjKANJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:09:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425F8B7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:09:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA6AC433C8;
        Wed,  1 Nov 2023 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698844147;
        bh=Vz7ysH7cNtXbCT5BC7mDROjCTpfVrCFSPMZSO5EqKLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjeqgvQK/oLxdfX5EEKWcza3KCJBMGLhXGTeqA8Ly6fm2cGjUi+UYRJHgMMZLxgmd
         4U9j/nT60wdjDJtvHWxe1/UgpRobNH+rJuGmJAgwDy9QMeuAsS44mJwZLhx0f2oHN6
         AlsrQOlDedpsGAh8kmCc+lhCBwqFOORxzimODwRrpWjDhLv8kK8/gaQWXquvgeyGtr
         PWKD0a5NHbQT4f+0ZYezPb5eAICeXNTVpLTXcblv8r+x984Yp7I4qPLkYRso9UwgKB
         5C+o1+5KgHBTVN1Qttts6rfF8nIDMdfMSIv0NvS4IgIsR6HL95NtQ5UgyO8Ih5n9Ct
         KVf3okKzS/Vhw==
Date:   Wed, 1 Nov 2023 13:09:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Add option to prevent disabling unused
 regulators
Message-ID: <c1690b26-9004-4e5e-aa14-c61f679add12@sirena.org.uk>
References: <20231028102423.179400-1-javierm@redhat.com>
 <20231101045652.GA2897@thinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NoDpa3jvoxiVIWee"
Content-Disposition: inline
In-Reply-To: <20231101045652.GA2897@thinkpad>
X-Cookie: P-K4
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NoDpa3jvoxiVIWee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 01, 2023 at 10:26:52AM +0530, Manivannan Sadhasivam wrote:

> On the other note, I'm wondering if we could use sync_state() for handling the
> regulator_init_complete() work. This would ensure that the regulators are only
> disabled when all the consumers are probed.

That assumes that everything defined in the DT both has a driver and has
the driver available for the currently running kernel neither of which
is a good assumption.

--NoDpa3jvoxiVIWee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVCTewACgkQJNaLcl1U
h9DA+Af/ehW2mCrAxO2tgVL9SyRKQuTI6KLs0SUMuRpUZ9hZNCbwHAVnWktnP5K6
DlYJukivxKx3vTd3FgRoUMdEiX1YblU9yKgJP3SQk0492iGZGr+wcwXEpZ4+DJ/G
wEq55hS3KPbe1rWMIAu4yJx+mdc6sYl4ypckMyxy3CLUkCD8WSIdY+lLm1uVxAT/
c/cXcRYtrixUX//OtRcpWK1WeXNG4sudiobU6ZbHTFQe+11+pM7dd9l358kUEWhJ
V98Cr0NW4foqYSM6PbiLTTpMBj8B1gr6MPtLvB5QbhVs9OyNzapMNZ1VD99JCNCr
Gf43q9CWYaL9QWzfDq2wnujt66+NPw==
=pOwA
-----END PGP SIGNATURE-----

--NoDpa3jvoxiVIWee--
