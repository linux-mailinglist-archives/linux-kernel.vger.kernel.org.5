Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986B7809547
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444106AbjLGW1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjLGW0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:26:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3030170F;
        Thu,  7 Dec 2023 14:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701987996; x=1702592796; i=w_armin@gmx.de;
        bh=MgzcGVPKoqfJELwV3CzTRBVexp97HcHn6k8nAs0yc08=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=pC5qFLaOiFTDVxkVktFEMNHu+evSRL9sPTF3IEPpoyTtssn2e/mUf/YVmiuAQW05
         2+WtvdT1CUnYm8Hs3Kv9zh+qGHJDfZ0LnNXTFrOVTGuXJQ3z86wjPLrIbFO0bALMa
         2UiHBY0g0+nRnxqZ9EstRuXddP79WlUEq0eX9V0kTzT4GPpz8Ca4IOJiwy0r4YVhx
         Gi7vgPydqztRWI1f6EvFUUqK3PdR/rWDBxGy5zX8z9FVGijXMHxPNhgblJx6fHASg
         AUBtO0GRafpQtU0RYmwDoWhBAN+xuUVP+A2Iv/MrFcOekjJQkrYgZOaIZ/r2C4Ay6
         fKEWKejoaNKwLRjomA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MmDEm-1rbw9U2DMe-00iB3d; Thu, 07 Dec 2023 23:26:36 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] platform/x86: wmi: Cleanup obsolete features
Date:   Thu,  7 Dec 2023 23:26:18 +0100
Message-Id: <20231207222623.232074-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+V6s3WudzRkc/3U5Azxmw82Gi8PIOKICgFml6vaMiONzNt8X8D8
 RdOQHPqXh6/Hpe7zxdER4A8Pa9R3U6NuTYzY8E1c1jeS+EULdbuOHnBLZ1rXBfPPBCRui2d
 WRW13bHWUnXgiKnrn4Xo8/NBZfs0P77LeidQZNV4DYz3o1xK1hDDLBKtPTsXfILhSI9cXRB
 5e9YyjXV/HEr1K6QTnfNA==
UI-OutboundReport: notjunk:1;M01:P0:Dhn/0EMwgHQ=;bxz3HihOqtq6cwc3l0KTYBCsPSW
 wf72mfYMm7eX55hx+eeTQJGxrhz1ktttzeesaMkMgV0Fc7T30HOXyDr8gD7tbbYRdpNpIAOI9
 ZgfbTkxdeQ2awZWbNxUPy1SDJWs6NPARPJr32iYLVRCeqIbBVDoAXl/Ob2XI3zuKywkTRIrMZ
 YLkt+A6zaSRuT/4ovnGGF2b0aPMJRPN3yCJpMOjjKOfS3/BQYlhJ+eKmfdZnfSVaBAXwODct7
 FkMV2oK2Agc4A0VyAaua6NxL+kvXAwqiFYIFtmvfKpWWvbK7Gb7uGMSzfUmVyjdUyxiGRGie5
 GXxnYFXViir9LdXZcITCRZxNO0py8VeSxjKiCGBiFBiLUZhDlvb0sHo0hTwEMLEtSW8Co36ja
 n9o53ZSeo8g0QW0X6sWzEIhKlp6tSJloKfe0rK4ZSscUczneUW3UvXhMlOYwYjFkTircH2FoJ
 W0QUIeRdNFeEQ1qjNrakaTrlafdJVbwR8+J5lXgg1q9wkOvpM+YVdvnWOdoH4zFJUX7ycFPgA
 apQx9uHk2oi0rRmJsynYYxk5NTQhHObLfUvvLVbwNtzbAe32R0U4v4dEzFyhx8/3MBmzGRGtZ
 NIlJCTY6VgkzTb8BtoKPltgVk8Tpqzlm7KQ4ejViik3UKOqA1zkUZmw6h+VPmZtiR58/MmCED
 mw6QWohWpbSenwDpPLPnKp+BCQxEKNddZZQRELDj0W9afSZiLSuk33XfKZIbTL3Blrj6jlhFc
 fcKjCg1fFO986Y38KL0mD3cH2OyBYrVsFr+MaY6kvA/2r/+FDWCgOznQqtiDh6xlPQ+J0KweS
 HZM6UBSLda5ghrGgtaMJG6hrt2a42HlhMaHc73PXRGSxR6xTcOAqcTc45nb1O+T9/hMlvXa5m
 GOsWU0T6aMwWchxlp3dOsTxmk0N+de8VJKw6zdjjk5aO3nFAyMqGPOySPjPTAn0GbX4dnTZ3W
 qVPJWbHzNN9AGpGcSochRoZ6H9k=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes three features deemed obsolete:
- the debug_dump_wdg module param:
  - suffers from garbled output due to pr_cont()
  - functionality is better provided by "fwts wmi"
- the debug_event module param:
  - pr_cont() usage
  - uses the deprecated GUID-based API
  - largely replaced by the ACPI netlink interface
- ioctl interface
  - used only by a single driver, no adoption otherwise
  - numerous design issues

Since the ioctl interface is actually used by userspace programs,
the only user (the dell-smbios-wmi driver) was modified to implement
the necessary pieces itself so that no regressions are expected.

The last patch in contrast adds a short WMI driver development guide
to the WMI subsystem documentation, so that driver developers stop
submitting WMI drivers using the deprecated GUID-based interface.

The series depends on
commit cbf54f37600e ("platform/x86: wmi: Skip blocks with zero instances")=
,
which is currently in the "fixes" tree.

All patches where tested on a Dell Inspiron 3505 and work without
issues.

Armin Wolf (5):
  platform/x86: wmi: Remove debug_dump_wdg module param
  platform/x86: wmi: Remove debug_wmi module param
  platform/x86: dell-smbios-wmi: Stop using WMI chardev
  platform/x86: wmi: Remove chardev interface
  platform/x86: wmi: Add driver development guide

 .../wmi/driver-development-guide.rst          | 126 ++++++++
 Documentation/wmi/index.rst                   |   1 +
 drivers/platform/x86/dell/dell-smbios-wmi.c   | 163 +++++++---
 drivers/platform/x86/wmi.c                    | 285 +-----------------
 include/linux/wmi.h                           |   8 -
 5 files changed, 256 insertions(+), 327 deletions(-)
 create mode 100644 Documentation/wmi/driver-development-guide.rst

=2D-
2.39.2

