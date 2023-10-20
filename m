Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423457D12E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377790AbjJTPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377764AbjJTPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:34:36 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A135BE;
        Fri, 20 Oct 2023 08:34:34 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 0015C4196A;
        Fri, 20 Oct 2023 20:34:11 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1697816052; bh=vWCRQ4fNqO5LRt80eRCCPf+N3EAHFNSQHWlhv9+dG6E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Z5L8FNDHYVBWFYR9uyEnwZMsgSWAsqlUfbTtakJ/TMRhONV/QkHnm0lEqnlsogkgz
         yHOaFyEDZLarArP+uO5ELIebdAt0fs/XFPZ/0m2lCVCJtuAwO8lGM+ttEjzN0h9vO7
         O27uay2hl4KnH1YTPO3wmIA+A0pzfILS3L2nh1FODUbrBiENORTCIMhpv3VoVxZRi3
         WPN/gfLxe/fpYeNQc2adVVDN8JAelNxH7J1YW8eFlHWCcWb/plmdxraFa8b8AldWuz
         QoqXwK6zLGyTRqEftjkyMn6sD/nZxVuZyhMfURLm17A3Ii5xQADyevclHH0WJ0jL5/
         gDooo9iaZPscw==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Fri, 20 Oct 2023 20:33:46 +0500
Subject: [PATCH 1/2] ASoC: dt-bindings: qcom,sm8250: Add
 sc7180-qdsp6-sndcard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-sc7180-qdsp-sndcard-v1-1-157706b7d06f@trvn.ru>
References: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
In-Reply-To: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     jenneron@postmarketos.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=vWCRQ4fNqO5LRt80eRCCPf+N3EAHFNSQHWlhv9+dG6E=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlMp3yDEpr0K/LD9Xkj5hdVslBNDAbnX6DeW10o
 V2dYQ3vvpWJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZTKd8gAKCRBDHOzuKBm/
 dQxLEACIgUXHeK+5Mt/vq/zZhrJ6L8IscDRn96d3J9M5M3UFS8rBRJhkZwS1yzijdRdklGJc+bJ
 67jfqHdMxEWEw+1lLnl36JnPO6Rp6hHYQGnVioObJ/C+G+LdZiKl5Io64RE/S+uJ5YiObB5UfFP
 5KOvW68PL9J5YILWCkZIuA+HkBwe0tUr5bC+8n/ps1Y/BxsgzhQx6KkwQFGNwDQxlTPD0aQQFrD
 nwfPmVYElfosTlxDgxRbxpdpX/aG8OaEZ3mRwj/a0TZwh2xuZh+76dhNRP1Lq+iWrRHVRVpVrGt
 TsTVUyQbM/ruIjLsNuS8y4KGVSASAT1UJb7ukkZ2ggsreO6h63aoeOIlYC/ZQNCe6sfAXTUsj7N
 IFfeUkKSKs1zWsMxLiZQgXzHqtMtFGx+vGEqZeTUJ0P8j4GhBZ/d02LgSfFoHmD2y6O7zACu/Fi
 NirMMU/b9RZtVK/wvZjwGUKW3+ayLUqoTznBsEkL7qvo5rvuWFZR0fH7tiweubxwXlcUuBXXfMO
 l8aWeqd/LuqGYBAIfPdOFXNc4FBoTaPB5qIMqRda9mMhMg7s92XX+cdV5bXP1/WhChiAFaVCjbW
 sYAQ/cSIhUCyGSvf8lhjfeljKxtbZG2my3DC+4TYcS0jdPDVg7SV89MvoB8Kg8WVkj5FHhqHmS8
 gaJOOsSZnpyWFPA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc7180 can make use of the adsp-baked soundcard, add relevant compatible
to the documentation.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 262de7a60a73..e082a4fe095d 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,apq8016-sbc-sndcard
           - qcom,msm8916-qdsp6-sndcard
           - qcom,qrb5165-rb5-sndcard
+          - qcom,sc7180-qdsp6-sndcard
           - qcom,sc8280xp-sndcard
           - qcom,sdm845-sndcard
           - qcom,sm8250-sndcard

-- 
2.41.0

