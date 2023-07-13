Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0FA752692
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjGMPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjGMPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:18:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729D2713
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:17:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b852785a65so5437515ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689261470; x=1691853470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkYvuheuXxUs7lcziZSh45/cEYAEtU5XJFKyTCEdPAw=;
        b=cPJcXmarGy/THqQS5YeBkXPiaUN6TNcqTUg4N/gUAzoGAZF/YDWi+9CV32JMSIufHf
         eGsnoa5VCpDibdNPlLNPjuhC9X10Y6IzZKZ5yyqVwPbcisWxLeeFYoeOXaYpVctMNeXc
         bk0rfmLISbTW1sVPcX48CvKFHh/TxKtg2ph3oCO38dWTM+Nz2U7TgMbCLLf1y0mIeUFs
         2JeQ2xUbm9WYLUT3c+PGSaud31GKWHfdJgZGHaQwDvPc5QGQn9hD+tYyISUmqRT9Nbrv
         BcTDGVhWLoADC58nzgh6sKcjBRZS2gMNCPM3Xrz0j3dkS6FpEiiMWSFYZ1zpRJ6PuBpi
         65Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261470; x=1691853470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkYvuheuXxUs7lcziZSh45/cEYAEtU5XJFKyTCEdPAw=;
        b=aPDRQMGt0FmVdJOUeqLWNHY3xpvC6epxIwPTv7vAzgIkTK8DLMBt2Af1vUaxbSWzLv
         LKYXCuJO0o5R0GxZPUJeBS39j/0iiSqdq/deoZsAJEQisrAtJIW7qBKwN5ExIEK9vvqY
         S3cEkl3PR6EFf62EsfSH2U7Seb/8r8myla8Y4n+50m91Tl1172cga1cqmWyU1+9fTqf1
         e5gm7y03FXAg/VQwYpCN7vwrw+2Mwj4TvNqX5QXeNqWgJOtrNk92yCpD6uHG1A65iH/4
         gqFM9tQHaBtLkPB19H2eFkGP3zWuXjzyOEpnJIQsau+cBpRVseFkXuQYcW2v67mT37lD
         4YgA==
X-Gm-Message-State: ABy/qLasl5IAYr/U2lyh/q0WRwTrFB17PZu4v5jdMx1EMMMqikNTAmAY
        t7KsLPorfGImOvkH7kaol2I=
X-Google-Smtp-Source: APBJJlHqbZ9l5bN1xWh2PTo56lO26Opa/ZRbOUhSfvD4lbvNfmbnAzKjlum4jgW8YgbdEOFDj1ZOlA==
X-Received: by 2002:a17:903:41cb:b0:1b8:9846:a3b2 with SMTP id u11-20020a17090341cb00b001b89846a3b2mr2736704ple.14.1689261469776;
        Thu, 13 Jul 2023 08:17:49 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-70-13.dynamic-ip.hinet.net. [36.228.70.13])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001b8a844b023sm6043640plb.272.2023.07.13.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:17:49 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: q6dsp: q6apm: make g_apm static
Date:   Thu, 13 Jul 2023 23:17:43 +0800
Message-Id: <20230713151744.86072-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sprse warning:

sound/soc/qcom/qdsp6/q6apm.c:30:14: sparse: warning: symbol 'g_apm' was not declared. Should it be static?

No functional change intended

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 7bfac9492ab5..d5ad9cbd3c21 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -27,7 +27,7 @@ struct apm_graph_mgmt_cmd {
 
 #define APM_GRAPH_MGMT_PSIZE(p, n) ALIGN(struct_size(p, sub_graph_id_list, n), 8)
 
-struct q6apm *g_apm;
+static struct q6apm *g_apm;
 
 int q6apm_send_cmd_sync(struct q6apm *apm, struct gpr_pkt *pkt, uint32_t rsp_opcode)
 {
-- 
2.34.1

