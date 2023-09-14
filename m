Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC6C7A0BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbjINRs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbjINRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:48:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DE71FF5;
        Thu, 14 Sep 2023 10:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da9Rn6+HJqcuDQJdmYkCnasAZ7JNl5IpL2MtvLMkScmhm9kt9ml4WEPJS4fmnUeIPKUmjPDAzYPNHYtD8iYW/mihZ9LfrEAtds2329Z5GjVpEi3eH/5V8B2fAPuoHX7EFVRS3j8mTTuiqQQJAWQGLn4ms7FhT2jy8KwoA5EykyVyOJhY/L5/rISil/j3lbRfgkLGuFbUzDhx8+pz8VtafSBBNoOq6S6GC/7LEovbv13A2BwHed4x3XRyuRxhufCC7U8j0adS7zqM0yTMaP6tXRMVt+bzWg2e3dMlRXZdRk5+2DZcmJhVK4Et7mie2Y4w0MMiL/y/w3qnfGOzmm4tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSRCzi0Wc61SYBfDPQWQu48usYm38FAYK91Pzf0Woe0=;
 b=iwr/WTje2wDSOQC7DLa4eL6vXgOsXYIL7BuiFHcpHIiouRmu2xnAmWlBH9qb5R1MHJ+WDyBSdz6tZ/OWMXo+jXwFFMt0UYrBIfPRkt3chnXvY/5o2sR88xNXSFX1s/HEB/KCQjZ2c5vzSs6CMaKCGQgk4QxMrxP06Mo42rMEPvcfv2HwztMBgyXHI+c6CchFYveZKzLxmLT6TkfdBQCi8XZYZPx7TtXi6+IqgjQeIfvGF761xQKxFkDFnKc2EubUw3L2WIN/9ywaG/r0W0TL3jFcCZutPCJuHpsQpxNcz5Euu1bnivFTxpwvDPcV3EyuqwAbj3mQkb5enK33GUOS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSRCzi0Wc61SYBfDPQWQu48usYm38FAYK91Pzf0Woe0=;
 b=42TiaFEred4swMJY4ZBn4PhOag4ueXWidG+LnwJyiJeDToNGwAlnTGuyUdWmXlEniJB1AHBhRvZe5LnKKqImOsumrBtVeP5MdwQxLJ7oEsPpAL8X1EupoE36cJIw/p0oOWcclc+X7W4cM++fW7EKV1A3lHG4VrbmFD8v2jOpxcI=
Received: from BLAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:208:335::23)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 14 Sep
 2023 17:48:14 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:335:cafe::42) by BLAPR05CA0043.outlook.office365.com
 (2603:10b6:208:335::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Thu, 14 Sep 2023 17:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 17:48:12 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 14 Sep 2023 12:48:11 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 1/2] docs/sp_SP: Add translation of process/security-bugs
Date:   Thu, 14 Sep 2023 12:47:51 -0500
Message-ID: <20230914174752.3091407-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914174752.3091407-1-avadhut.naik@amd.com>
References: <20230914174752.3091407-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 095376d1-0618-4767-4320-08dbb54ac45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zlhT/NqrpEDzb3U3XDkLobRmyiAK9eUv1/1e5S+OY6xUmmyTvwR6pv7KTCC8XLYpVEih+d9hrOzwyGn1H7yxj/uetDJpI2MPHmesCbg8Ifr8lO5r1Dl9tYurXlJ0xKtAXSWhThaVDthCLDHloKfWtJ0vNZe29HgsV5ADySG3XVb/TruO7AFtfa9L9N9yDYlqnyEoU+S4lps1laantGJ5NCBQGPsSO/J9TxuYnkeOaHm/LzVqN3y1f+5khku+XiOCisTNn2rw0s9XSzpvB67prrahZQnTeMNr6ZvjLdvWG6ePY4KDs3Gs/b3jRTOq+AE4Gvl2zviZqNKf6dT4VaGBrL5eniDBAcSaBnm+3jo40B7zkvMuwfYtrwDccOznLcoUJAaDyNnRa/VnXCl7KCjRXIH+BQw6Gbd/gO/Ssa/mJtZpSLxPtOrAM6evAgC+ZCWsHEoM0CVYibci3CBC99r0yyBRJeBH4vAzzS0KCJK4C4y0k2AYrFAbczne3qBp6ovwoqwrIJU/+PWCloT+LcqLcX845Kr3Iys7G7K+5yB+aq2kf/c1+O3CPKow8DFze0lxtCgUKerszhcfaiyFXCBgXi6n/Vl8ycDhCZyQfFs9bXGdT108T6uADzKNd/solaIvdXsStpU0JQFJK8inT3TmZz0GMSo6faWwma4AaJGHNa6L4+0n0gfdRznnd4A8+XVqYpJ1lgKlJ8O5P5CaH2KfKI5zAu+1GPFXQFfkgaCnDyHeYillimmgug0R79PzOH6wsuUeLjfsohcftn7NPGhKZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(46966006)(36840700001)(316002)(1076003)(2616005)(2906002)(40460700003)(336012)(26005)(426003)(16526019)(7696005)(15650500001)(83380400001)(6666004)(36860700001)(40480700001)(47076005)(356005)(82740400003)(66574015)(36756003)(81166007)(86362001)(478600001)(5660300002)(8676002)(4326008)(8936002)(70206006)(6916009)(70586007)(54906003)(41300700001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:48:12.9529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 095376d1-0618-4767-4320-08dbb54ac45f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/process/security-bugs.rst into Spanish

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../translations/sp_SP/process/index.rst      |   1 +
 .../sp_SP/process/security-bugs.rst           | 103 ++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/security-bugs.rst

diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index 09bfece0f52f..12cb63a6ea65 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -22,3 +22,4 @@
    adding-syscalls
    researcher-guidelines
    contribution-maturity-model
+   security-bugs
diff --git a/Documentation/translations/sp_SP/process/security-bugs.rst b/Documentation/translations/sp_SP/process/security-bugs.rst
new file mode 100644
index 000000000000..d07c7e579b52
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/security-bugs.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/security-bugs.rst
+:Translator: Avadhut Naik <avadhut.naik@amd.com>
+
+Errores de seguridad
+====================
+
+Los desarrolladores del kernel de Linux se toman la seguridad muy en
+serio. Como tal, nos gustaría saber cuándo se encuentra un error de
+seguridad para que pueda ser corregido y divulgado lo más rápido posible.
+Por favor, informe sobre los errores de seguridad al equipo de seguridad
+del kernel de Linux.
+
+Contacto
+--------
+
+El equipo de seguridad del kernel de Linux puede ser contactado por correo
+electrónico en <security@kernel.org>. Esta es una lista privada de
+oficiales de seguridad que ayudarán a verificar el informe del error y
+desarrollarán y publicarán una corrección. Si ya tiene una corrección, por
+favor, inclúyala con su informe, ya que eso puede acelerar considerablemente
+el proceso. Es posible que el equipo de seguridad traiga ayuda adicional
+de mantenedores del área para comprender y corregir la vulnerabilidad de
+seguridad.
+
+Como ocurre con cualquier error, cuanta más información se proporcione,
+más fácil será diagnosticarlo y corregirlo. Por favor, revise el
+procedimiento descrito en 'Documentation/admin-guide/reporting-issues.rst'
+si no tiene claro que información es útil. Cualquier código de explotación
+es muy útil y no será divulgado sin el consentimiento del "reportero" (el
+que envia el error) a menos que ya se haya hecho público.
+
+Por favor, envíe correos electrónicos en texto plano sin archivos
+adjuntos cuando sea posible. Es mucho más difícil tener una discusión
+citada en contexto sobre un tema complejo si todos los detalles están
+ocultos en archivos adjuntos. Piense en ello como un
+:doc:`envío de parche regular <submitting-patches>` (incluso si no tiene
+un parche todavía) describa el problema y el impacto, enumere los pasos
+de reproducción, y sígalo con una solución propuesta, todo en texto plano.
+
+
+Divulgación e información embargada
+-----------------------------------
+
+La lista de seguridad no es un canal de divulgación. Para eso, ver
+Coordinación debajo. Una vez que se ha desarrollado una solución robusta,
+comienza el proceso de lanzamiento. Las soluciones para errores conocidos
+públicamente se lanzan inmediatamente.
+
+Aunque nuestra preferencia es lanzar soluciones para errores no divulgados
+públicamente tan pronto como estén disponibles, esto puede postponerse a
+petición del reportero o una parte afectada por hasta 7 días calendario
+desde el inicio del proceso de lanzamiento, con una extensión excepcional
+a 14 días de calendario si se acuerda que la criticalidad del error requiere
+más tiempo. La única razón válida para aplazar la publicación de una
+solución es para acomodar la logística de QA y los despliegues a gran
+escala que requieren coordinación de lanzamiento.
+
+Si bien la información embargada puede compartirse con personas de
+confianza para desarrollar una solución, dicha información no se publicará
+junto con la solución o en cualquier otro canal de divulgación sin el
+permiso del reportero. Esto incluye, pero no se limita al informe original
+del error y las discusiones de seguimiento (si las hay), exploits,
+información sobre CVE o la identidad del reportero.
+
+En otras palabras, nuestro único interés es solucionar los errores. Toda
+otra información presentada a la lista de seguridad y cualquier discusión
+de seguimiento del informe se tratan confidencialmente incluso después de
+que se haya levantado el embargo, en perpetuidad.
+
+Coordinación con otros grupos
+-----------------------------
+
+El equipo de seguridad del kernel recomienda encarecidamente que los
+reporteros de posibles problemas de seguridad NUNCA contacten la lista
+de correo “linux-distros” hasta DESPUES de discutirlo con el equipo de
+seguridad del kernel. No Cc: ambas listas a la vez. Puede ponerse en
+contacto con la lista de correo linux-distros después de que se haya
+acordado una solución y comprenda completamente los requisitos que al
+hacerlo le impondrá a usted y la comunidad del kernel.
+
+Las diferentes listas tienen diferentes objetivos y las reglas de
+linux-distros no contribuyen en realidad a solucionar ningún problema de
+seguridad potencial.
+
+Asignación de CVE
+-----------------
+
+El equipo de seguridad no asigna CVEs, ni los requerimos para informes o
+correcciones, ya que esto puede complicar innecesariamente el proceso y
+puede retrasar el manejo de errores. Si un reportero desea que se le
+asigne un identificador CVE, debe buscar uno por sí mismo, por ejemplo,
+poniéndose en contacto directamente con MITRE. Sin embargo, en ningún
+caso se retrasará la inclusión de un parche para esperar a que llegue un
+identificador CVE.
+
+Acuerdos de no divulgación
+--------------------------
+
+El equipo de seguridad del kernel de Linux no es un organismo formal y,
+por lo tanto, no puede firmar cualquier acuerdo de no divulgación.
-- 
2.34.1

