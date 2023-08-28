Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6939978A4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 05:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjH1Dt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 23:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjH1Dts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C55BF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 20:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBFE16186E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAB6C433C8;
        Mon, 28 Aug 2023 03:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693194585;
        bh=nIU5Y40PPwCVo5Q6vWQ9pHPCH7jwV+1V6I6m9Zp4IXo=;
        h=Date:From:To:Cc:Subject:From;
        b=KXle4YPxuzT6hq6W1u59BzCqxyZ0gzHtQtcvOzrWunYts7LUWi9rii0b0fS7WWmAr
         2+xb0T7zfgD5qjmRqIm8m52iCYQ1+0gZO9a+r++XMCiiJMJxUITJX6D1Y2VDr9GPgQ
         C0R9oe6Mo7g/JPQDwMne6UgNuQ1EVdu6ntm8MX0tQ8IS7i0AxHeH7FKNDtYS9E6DXP
         GVBLC+5XrhvyRQgbcPJKGcJMlT4cEqnpi4/y1ZnEhnamRB8y1OHG3LzboleNSs5yFh
         BufbtUdJnA0DAZhHtNBGcp6ZrqttrphKN+nxqbHwoaLY2kMcReAsHM8iCAjjcLKh/S
         0KsZdomsNpwOA==
Date:   Mon, 28 Aug 2023 11:49:41 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        tzungbi@kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v6.6
Message-ID: <ZOwZVavwRm6PlsXG@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TbHGzPEnbzPOZWmR"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TbHGzPEnbzPOZWmR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull chrome-platform updates for v6.6.

Thanks,
TzungBi

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.6

for you to fetch changes up to 0820debb7d489e9eb1f68b7bb69e6ae210699b3f:

  platform/chrome: chromeos_acpi: print hex string for ACPI_TYPE_BUFFER (2023-08-10 11:10:56 +0800)

----------------------------------------------------------------
chrome platform changes for 6.6

* Improvements

  - Remove shutdown timeout on EC panic for offering the filesystem a
    chance to sync.
  - Support official HID "GOOG0016" for ChromeOS ACPI.

* Fixes

  - Print hex string instead of using "%s" for ACPI_TYPE_BUFFER.

* Misc

  - Update MAINTAINERS.

----------------------------------------------------------------
Rob Barnes (1):
      platform/chrome: cros_ec_lpc: Remove EC panic shutdown timeout

Tzung-Bi Shih (3):
      MAINTAINERS: update maintainers of chrome-platform
      platform/chrome: chromeos_acpi: support official HID GOOG0016
      platform/chrome: chromeos_acpi: print hex string for ACPI_TYPE_BUFFER

 .../ABI/testing/sysfs-driver-chromeos-acpi         | 17 ++++++++++-
 .../firmware-guide/acpi/chromeos-acpi-device.rst   |  5 ++--
 MAINTAINERS                                        |  1 +
 drivers/platform/chrome/chromeos_acpi.c            | 33 ++++++++++++++++++++--
 drivers/platform/chrome/cros_ec_lpc.c              |  4 +--
 5 files changed, 52 insertions(+), 8 deletions(-)

--TbHGzPEnbzPOZWmR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZOwZUwAKCRArxTEGBto8
9IjMAQCiJy3WJaa73CFJHjkgNDcVM2sWp+leRguvLvLC4MFRMwEAuMF8Jt0u0FJe
kmUIBwGfdH+bJmkX0LURRaer3T1ScQM=
=GekC
-----END PGP SIGNATURE-----

--TbHGzPEnbzPOZWmR--
