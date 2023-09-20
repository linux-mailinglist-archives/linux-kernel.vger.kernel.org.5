Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875307A822E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjITM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjITM6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:58:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C24D9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:58:15 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 553688C1;
        Wed, 20 Sep 2023 14:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695214595;
        bh=5q1owDkQaoGqwq0Zdzsk/qGzGO+Yc+ytGxQsqq2luVY=;
        h=From:Subject:Date:To:Cc:From;
        b=fvHJLS0E0Tqy1a71xDBQADRFgiE56um5w0FsplxpmiwA9aQtv0r581E1VmcerxWpT
         aBBlRL3KHCJ4Dh3noO11AECSfCbeKFERfBUtRrlQ7IxYGhENwSBFyTt/A67cOWzcWz
         S0hNaLx2A+3kd1jr7PeZTpPGqO3TaWPAxeixb5EQ=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] drm: Revert dma-fence annotations from omapdrm and
 tidss
Date:   Wed, 20 Sep 2023 15:57:15 +0300
Message-Id: <20230920-dma-fence-annotation-revert-v1-0-7ebf6f7f5bf6@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACvsCmUC/x3MQQrCMBBG4auUWTuQphCqVxEXY/PHzsKpJEEKp
 Xd3cPkW3zuooSoa3YaDKr7adDOP8TLQsoq9wJq9KYY4hWsMnN/CBbaAxWzr0h2wS9TOY0o5oMh
 zSjP54VNRdP/f74/z/AHJjfhKbQAAAA==
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jyri Sarha <jyri.sarha@iki.fi>, David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco@dolcini.it>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=5q1owDkQaoGqwq0Zdzsk/qGzGO+Yc+ytGxQsqq2luVY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlCuxfkEWU98ub7pHgA8iAQXohfVqLaobnR488E
 eS3ra1zl9OJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZQrsXwAKCRD6PaqMvJYe
 9TlNEACild+chY2IvxEVyN5tomstOEsOd07E3ec8Br5CcX0PdSlXgqiEi4+jlxmX95THoNIKZa0
 6c+p4SWHTzNXxXuqHcOhvajCy1L9GRmZUhNLzRBhEAtq9Q8cL7tU34y43kSWK5ab5skSWMFIwZf
 nGmdRI5CpP9C2DzrwAHeUCF0bIGZyE+ukBb/mJtPIIRtJyBLvG8KorxFVVfh5E/yciWc2r4rFVA
 yS9k112OunuD/q2AMOBJ2ohujJggc/bgGXv24YJpQrTeSh/yJx2JQJVHtDe0zBY4ZiQjzvW/IsX
 vzKmFQzWfEI6J6icWv5CIRIMI9v9nGcPeFpKgtM3z5TjikG8z1TBWXy4mcwaIVS1dIwN0eT7uZ5
 i9EwBgo9q3aVp8Kw1U6UnCTWAkmWun2htBhsbcnh7sP/T2YP1DNASJ9JnqzFCRi4JUMk9pEwkOo
 cY77uQ7O1NE7xQwj/rjuP3R7UFAbz/QM0fbtA1j4dizrBszjU10IaSiR6IEi8MyWnsrDNmtg8ZZ
 zMjYVB5m2OCXgZLACIwGbfiM+Q3zQZw8CSn6YM7Yk5Ohe1t9VI4jzVYaUc7rbySQN+o83uVavJ+
 7yZyOsp0IeA7YKm24+OoGvsJVPSMcvoFo0ufgmnjdgrgyTpXf8Yp977CcNl/oUfjYUa0udSpUGh
 1NvShHSK3HZghmQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both omapdrm and tidss give quite similar lockdep warnings ever since
the "Annotate dma-fence critical section in commit path" patches.

I've tried to look at this, but I haven't gotten far with understanding
all this, and I feel that I'd need to really dive deep into the details
to understand all the locking dependencies relevant here.

With some git-log digging, I noticed this:

https://patchwork.freedesktop.org/patch/462170/

So maybe the "fix" is just to revert the patches. If yes, great, we can
apply the patches here. If not, not so great, and I'll just have to
start the diving =).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (2):
      Revert "drm/tidss: Annotate dma-fence critical section in commit path"
      Revert "drm/omapdrm: Annotate dma-fence critical section in commit path"

 drivers/gpu/drm/omapdrm/omap_drv.c | 9 ++++-----
 drivers/gpu/drm/tidss/tidss_kms.c  | 4 ----
 2 files changed, 4 insertions(+), 9 deletions(-)
---
base-commit: 9fc75c40faa29df14ba16066be6bdfaea9f39ce4
change-id: 20230920-dma-fence-annotation-revert-166d0efab368

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

