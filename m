Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9D756BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGQSRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGQSRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:17:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9861989;
        Mon, 17 Jul 2023 11:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMyy7kH5Nh6gIxSHCn7yUwWiaVLtM64zAvDXUljYqXnz9blzO+7Cr7IsP7CB4uApOm51qAxAo3yxAP687JKj8xlgFbf/TZLf1Xz5IlUeo924mzov7G1MS4yayNQkvd1PKA/0zoILh4e8KPoqy9AZNyi850374z0VmcerhnvXRM9H5gYMYx4Wayl0a6mU0jm2ZT9wePtZlsFnjf6Fy9C2UvxITkAW2j7fDU00rhHbjYvb/GPGpsupkMJvs7/423oxKWLzKoGVObgMbErLl37QUJwX8xVkkl08NaomMGEFVOWAYXeAOj+mGqdMqihHgyFEbh1fVRxACjx89GJHKNmJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwM1kV6kX55DK2d4VKvCRbLKJlk/ustRBCwsMpIqzsE=;
 b=W0II6/oAobZx4yfbP1KZw0JXHmO08ig4uMmAZP+80V91/xa5uBukFaheEcvhzCof39FrC85kHL6xjjRIeuWvufifI7UK2X29nmofAZ+wviX2P7C+WGwCKJTIEGd9eBMplIPfbHlOHz3USQ9u3FMxKxggzt1ccPtlR9gytsYW0Kt98SYJeOlQ/CP2W3ablvc8CumBgtIfSzq72zvfpUKgnrq1FjSvwEJGwGaHPyU+7TT2/copMXU4DMUP+Gp36Q99Oymm+o9xAVFLIfultUc6reqFC6+CjieTwV0FGwb6bMJMyhPSteEtLQXW61vNjzD2oKu1SnvORRTH9BP9boYiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwM1kV6kX55DK2d4VKvCRbLKJlk/ustRBCwsMpIqzsE=;
 b=36Jw7aYvvoWvqVLB2LqpGMUH2ofsniKiXM/UwkaQiqAJkRvDrHeN5+MLFVzcQJ+7wsdBEcRg3KfJh8uk7iPqXIAd7s3T+nKoc0iUkkqM9xeUH7hBy5LpXqjj53uJtHAuXtq3hDY2sYeLCAsX+yDPktPSqglDcpm+BpSReO4/x2Y=
Received: from MW4PR03CA0351.namprd03.prod.outlook.com (2603:10b6:303:dc::26)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 17 Jul
 2023 18:16:11 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::bc) by MW4PR03CA0351.outlook.office365.com
 (2603:10b6:303:dc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 18:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 18:16:10 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 13:16:09 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH] docs/sp_SP: Add translation of process/contribution-maturity-model
Date:   Mon, 17 Jul 2023 18:16:02 +0000
Message-ID: <20230717181602.3468421-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 39df6f29-1332-4374-ddd3-08db86f1e5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9qh2UmivixbctW1rG33DjPn1R4sNXsmcbtI9xpGTIaqHQ9UM3qclU/jWtVr2XHj/9qYNjoRlWlMeZqIzXkg8+bwdMfwX1Uu8Td0PZ68CkohHUpVgSdZgujql0RZC2aNn60cJ1POTft9wfN6HKTSyAhmGddWXzfMuoKYoy8FMt5YHkSi4r4BOEfRu+z7KpS5FlBaEFXi4kmYfTwzEF/KuINITyIxZjNuyQL5jxwCWfh/Gwh70Ln3H0HLz8zGuj7CLAwxYfhRLHERfK/8tJKBEGQmHSQnH7nt6g73EkbQ55USn5CmUwCspHUlKUQv5vzXYDurU/UsdOMAH/2+cE8e5Fw4aorrnjzxyo8yJtUGrIx4l6kK9QGikd66kR9i8vZKWJ4CkrzVX8iKiGeEn1T6NljK/QGpGDwpwjGGvVLBEz+2LuGPFmJM+/zE3uAGFuY6d3tpbNdyqR416eJ/8iCh9Ch4Rzm1tYVsB+H7CtQF2x7UHkAM+O8Rcwz1SIenASyyZDVBX69iROkmYAJzIOGVNCZ+1aufMwrY7vrHtGv5dmHWsbvoxSw3zr/QlGX82or3MeOehX4b8bYLC+NS9H6/VjW5ruaJ7Shv039xX8JqZAPuNisbZQWzCPdG9lAp8l4naNNhwC6rAo8+ZbUxFgJPfeB2EmmagQUAhxWfqechVxjydvqQ0gJB35+4hLB6P8Ki0QO2FqKvX/+vbNGqfVL6SNdwcD1tKkHYVLoSn5p6ikfRQQc5z+KtzJBN4ALXF68xtY3lhOhISfW7yR7/WP8tMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(2616005)(6666004)(478600001)(36860700001)(7696005)(26005)(54906003)(36756003)(40460700003)(426003)(40480700001)(86362001)(2906002)(82740400003)(81166007)(70206006)(70586007)(336012)(186003)(356005)(47076005)(1076003)(16526019)(41300700001)(8936002)(6916009)(316002)(5660300002)(44832011)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:16:10.5158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39df6f29-1332-4374-ddd3-08db86f1e5fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/process/contribution-maturity-model.rst into
Spanish

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../process/contribution-maturity-model.rst   | 120 ++++++++++++++++++
 .../translations/sp_SP/process/index.rst      |   1 +
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/contribution-maturity-model.rst

diff --git a/Documentation/translations/sp_SP/process/contribution-maturity-model.rst b/Documentation/translations/sp_SP/process/contribution-maturity-model.rst
new file mode 100644
index 000000000000..36a6f9727933
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/contribution-maturity-model.rst
@@ -0,0 +1,120 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/process/contribution-maturity-model.rst`
+:Translator: Avadhut Naik <avadhut.naik@amd.com>
+
+====================================================
+Modelo de Madurez de Contribución al Kernel de Linux
+====================================================
+
+
+Los Antecedentes
+================
+
+Como parte de la cumbre de mantenedores del kernel de Linux 2021, hubo
+una `discusión <https://lwn.net/Articles/870581/>`_ sobre los desafíos
+en el reclutamiento de mantenedores del kernel, así como la sucesión de
+los mantenedores. Algunas de las conclusiones de esa discusión incluyeron
+que las empresas que forman parte de la comunidad del kernel de Linux
+necesitan permitir que los ingenieros sean mantenedores como parte de su
+trabajo, para que puedan convertirse en lideres respetados y finalmente,
+en mantenedores del kernel. Para apoyar una fuente solida de talento, se
+debe permitir y alentar a los desarrolladores a asumir contribuciones
+upstream, como revisar los parches de otras personas, reestructurar la
+infraestructura del kernel y escribir documentación.
+
+Con ese fin, Technical Advisory Board (TAB) de la Fundación Linux propone
+este Modelo de Madurez de Contribución al Kernel de Linux. Estas
+expectativas comunes para la participación con la comunidad upstream
+tienen como objetivo aumentar la influencia de los desarrolladores
+individuales, aumentar la colaboración de las organizaciones y mejorar
+la salud general del ecosistema del kernel de Linux.
+
+El TAB insta a las organizaciones a evaluar continuamente su modelo de
+madurez de Código Abierto y comprometerse a realizar mejoras para
+alinearse con este modelo. Para ser eficaz, esta evaluación debe
+incorporar la reacción de toda la organización, incluyendo la gerencia
+y los desarrolladores en todos los niveles de antigüedad. En el espíritu
+de Código Abierto, alentamos a las organizaciones a publicar sus
+evaluaciones y planes para mejorar su participación con la comunidad
+upstream.
+
+Nivel 0
+=======
+
+* A los ingenieros de software no se les permite contribuir con parches
+  al kernel de Linux.
+
+Nivel 1
+=======
+
+* A los ingenieros de software se les permite contribuir con parches al
+  kernel de Linux, ya sea como parte de sus responsabilidades de trabajo
+  o en su propio tiempo.
+
+Nivel 2
+=======
+
+* Se espera que los ingenieros de software contribuyan al kernel de Linux
+  como parte de sus responsabilidades de trabajo.
+* Se proporcionará apoyo a los ingenieros de software para asistir a
+  conferencias relacionadas con Linux como parte de su trabajo.
+* Las contribuciones de código upstream de un ingeniero de software se
+  considerarán en la promoción y las revisiones de rendimiento.
+
+Nivel 3
+=======
+
+* Se espera que los ingenieros de software revisen los parches (incluidos
+  los parches escritos por ingenieros de otras empresas) como parte de
+  sus responsabilidades de trabajo.
+* Contribuir con presentaciones o ponencias a conferencias relacionadas
+  con Linux o académicas (como las organizadas por la Fundación Linux,
+  Usenix, ACM, etc.), se consideran parte del trabajo de un ingeniero.
+* Las contribuciones a la comunidad de un ingeniero de software se
+  considerarán en la promoción y las revisiones de rendimiento.
+* Las organizaciones informarán regularmente sobre las métricas de sus
+  contribuciones de código abierto y harán un seguimiento de estas
+  métricas a lo largo del tiempo. Estas métricas pueden publicarse
+  solo internamente dentro de la organización, o a discreción de la
+  organización, algunas o todas pueden publicarse externamente. Las
+  métricas que se sugieren encarecidamente incluyen:
+
+  * El número de contribuciones al kernel upstream por equipo u
+    organización (por ejemplo, todas las personas que reportan a un
+    gerente o director o vicepresidente).
+  * El porcentaje de desarrolladores del kernel que han realizado
+    contribuciones upstream relativo al total de desarrolladores
+    del kernel en la organización.
+  * El intervalo de tiempo entre los kernels utilizados en los servidores
+    y/o productos de la organización y la fecha de publicación del kernel
+    upstream en el que se basa el kernel interno.
+  * El número de commits fuera del árbol de desarrollo presentes en los
+    kernels internos.
+
+Nivel 4
+=======
+
+* Se anima a los ingenieros de software a pasar una parte de su tiempo de
+  trabajo centrado en el Trabajo Ascendente, que se define como revisar
+  parches, servir en los comités de programas, mejorar la infraestructura
+  del proyecto central como escribir o mantener pruebas, reducir la deuda
+  de tecnología upstream, escribir documentación, etc.
+* Los ingenieros de software son apoyados para ayudar a organizar
+  conferencias relacionadas con Linux.
+* Las organizaciones considerarán los comentarios de los miembros de la
+  comunidad en las revisiones oficiales de rendimiento.
+
+Nivel 5
+=======
+
+* El desarrollo del kernel upstream se considera un puesto de trabajo
+  formal, con al menos un tercio del tiempo del ingeniero pasado a hacer
+  el Trabajo Ascendente.
+* Las organizaciones buscarán activamente las reacciones de los miembros
+  de la comunidad como un factor en las revisiones oficiales de
+  rendimiento.
+* Las organizaciones informarán regularmente internamente sobre la ratio
+  de trabajo upstream a trabajo enfocado en perseguir directamente los
+  objetivos comerciales.
diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index ed6851892661..09bfece0f52f 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -21,3 +21,4 @@
    deprecated
    adding-syscalls
    researcher-guidelines
+   contribution-maturity-model
-- 
2.34.1

