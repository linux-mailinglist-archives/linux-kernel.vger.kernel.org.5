Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFF80BF3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjLKCiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjLKCiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:38:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07A8BD;
        Sun, 10 Dec 2023 18:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEX5KHTjUdvkb46VGldlx/0aEtJlLAxleslKTqKII1eEPbb65QqqiL/XxdB++PvpeKKA9uCZq64pacLhh+RIhufNRmQm7o4uksOHEKSUNEOaT6wTbwTaJKrs/ZkiDg7p6FkwU3TYSedFl2yM0Nl0ihaNHqbTEnvNhruegdguYUgaCClHNge2YhpTMbMb/VY4W4+CJsDTOllHv3JChP3RY4QvRCxd/UQY1Owte/kwZuxekzP2G1TB/t1h9604QUKAc4Ad5slN3MPRMkSJ0vASoDEJUbWWZMqRc+yOhk5PQ61RwX+UeWJ6U7QbDlbBn4gdT3BpcWXKovC8QZ0OgJtuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLiE6UKHKaO09BI0b87ml7ox4GDRkT81EgWlKfp6HPU=;
 b=G9a81wx6B1sESz0YcU3BKl+TyzAQuPac94pscqfBBJXnn7LWUY394b3Pzswa9lFcvEbNBss6M1bZdojYoio3xiGwFy8dHJTbdJ7n8rPsKm+iV7XbEkJAJa3MMXvorAzcBL4Fxoz9hkHOqWkch2+UWOk7Tfo42SQlFuiiSyw1YRHUa3sE5fnMBfWRbekG8phYlMzpyvVq+T7h4nb/itphtbbF/1h4RPY8vBdxBYemv7Qk/qoR4tmnqengkpbqAZy+KOr012xSnLAwW64AvqoMxzAyyjIFJTChu3PsonFU/24y1CPyNGHrH1+yd1woq1RqATQHNgq1acA7DU5me2VeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLiE6UKHKaO09BI0b87ml7ox4GDRkT81EgWlKfp6HPU=;
 b=uevr6uMEcZAUJAf9yIlSQsy+4fojLmpKzOscceiHLr22YFnebTcZBT6Y5PbNiaRTlHrzWl9FiCnEUASAkWn1GaECI7uMmXAqZ6Wrkk/IqYp6D2NywLWqZZmJHmCX85PjG6ipGRJhZXOXAn5b7R4DYFDsfvct8ejXrozJQQYoG88=
Received: from SA1PR05CA0014.namprd05.prod.outlook.com (2603:10b6:806:2d2::23)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.30; Mon, 11 Dec
 2023 02:38:07 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::14) by SA1PR05CA0014.outlook.office365.com
 (2603:10b6:806:2d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21 via Frontend
 Transport; Mon, 11 Dec 2023 02:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 02:38:07 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 10 Dec 2023 20:38:03 -0600
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 2/4] docs/sp_SP: Add translation of process/submit-checklist
Date:   Sun, 10 Dec 2023 20:37:28 -0600
Message-ID: <20231211023730.2026204-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211023730.2026204-1-avadhut.naik@amd.com>
References: <20231211023730.2026204-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 580d472d-d1d0-4754-ae1a-08dbf9f2354a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqsWwTt6XGrvEG+OWABPOGIVtKfSSuOI9hSYiQdEvFdq76u03U/3xWH0Cn5CqSlOS42atM/OZ1UtFf9LKA2ym5cgongexfrI3ymsFb8itQqYmGLLN9cEf+9Gp3xQsIUaTWmXQ3S9gswUOEol35FRyssji2vSrBun08nIVs6QtZvmdLT1Pz6/1T860B07fFyk4Jzwnq5JsNwtREn8yib2hJzd8TQU6hlsIZHun+elTmU9iuCi4PBSkwckcZ72Q31lijj3L7uxC/Ncf7hU+dhAAIQMpr82GaOmyH6+FdwO60lEUp3eHVL/HELz7fOoJA/hz5nb+Mkblqw9umvckrSTG8mYwfAfPdn8itfx6EjQt8uwEwbvzE9q220c8a6+H+NLRq1jO2JKQhDCde5Vo9UZoSN703bmsjc1yVZwn7aYaIioOPqryGK5LKYxHoyXQJbiHQNegXq1clZtFyP/TeYdbCsTld4pM9i2ceXZHM57PRtFL7y4hihJldV+2jd9w1YIffYmxOqGS1U4+verA2iN+fMLV81GvvVwH/v32skdKX8Y/hYT1leuVgNr2MdHhOM8S6eSvvKvrmmZQ80WOf+KQMFRNgK2p0SMonDQ+Ytqj4ONqGUgPjnSo/YlF7FAQD3MaK/sjymz12WYf+u1amRymiUf5njDwvDajJYYW/6Y23wcv2TUWODHkBQNzgCvLAq6ey+7Qqp0Ce82IB+G8wXTF/Y+aF1T0DJtSQ311nbXzcAgO0jpP3kP8VLnzYBI2uZNR2xHQx3sm2wCHQZNTPnsKmLkZLKkR68zgv1NjvmLilLZIQZ+CMN9Bga0rNXdocxgA/dmRKToFqaNMpqckrsv9Yngm1XGnpa+aq5YsjbUdx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(230473577357003)(230373577357003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(2906002)(81166007)(478600001)(356005)(41300700001)(82740400003)(66574015)(70586007)(54906003)(6916009)(70206006)(426003)(40480700001)(316002)(6666004)(86362001)(7696005)(4326008)(8936002)(8676002)(40460700003)(44832011)(36756003)(47076005)(5660300002)(1076003)(36860700001)(26005)(336012)(16526019)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:38:07.3920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 580d472d-d1d0-4754-ae1a-08dbf9f2354a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/process/submit-checklist.rst into Spanish.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../translations/sp_SP/process/index.rst      |   1 +
 .../sp_SP/process/submit-checklist.rst        | 133 ++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/submit-checklist.rst

diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index 2c6eda05ba7a..ebafa0e6055d 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -26,3 +26,4 @@
    embargoed-hardware-issues
    handling-regressions
    management-style
+   submit-checklist
diff --git a/Documentation/translations/sp_SP/process/submit-checklist.rst b/Documentation/translations/sp_SP/process/submit-checklist.rst
new file mode 100644
index 000000000000..0d6651f9d871
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/submit-checklist.rst
@@ -0,0 +1,133 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/submit-checklist.rst
+:Translator: Avadhut Naik <avadhut.naik@amd.com>
+
+.. _sp_submitchecklist:
+
+Lista de comprobación para enviar parches del kernel de Linux
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Aquí hay algunas cosas básicas que los desarrolladores deben hacer si
+quieren que sus envíos de parches del kernel sean aceptados más
+rápidamente.
+
+Todo esto está más allá de la documentación que se proporciona en
+:ref:`Documentation/translations/sp_SP/process/submitting-patches.rst <sp_submittingpatches>`
+y en otros lugares con respecto al envío de parches del kernel de Linux.
+
+1) Si utiliza una funcionalidad, #include el archivo que define/declara
+   esa funcionalidad. No dependa de otros archivos de encabezado que
+   extraigan los que utiliza.
+
+2) Compile limpiamente:
+
+  a) Con las opciones ``CONFIG`` aplicables o modificadas ``=y``, ``=m``,
+     y ``=n``. Sin advertencias/errores del compilador ``gcc``, ni
+     advertencias/errores del linker.
+
+  b) Aprobar ``allnoconfig``, ``allmodconfig``
+
+  c) Compila correctamente cuando se usa ``O=builddir``
+
+  d) Cualquier documentación o cambios se compilan correctamente sin
+     nuevas advertencias/errores. Utilice ``make htmldocs`` o
+     ``make pdfdocs`` para comprobar la compilación y corregir cualquier
+     problema.
+
+3) Se compila en varias arquitecturas de CPU mediante herramientas de
+   compilación cruzada locales o alguna otra granja de compilación.
+
+4) ppc64 es una buena arquitectura para verificar la compilación cruzada
+   por que tiende a usar ``unsigned long`` para cantidades de 64-bits.
+
+5) Verifique su parche para el estilo general según se detalla en
+   :ref:`Documentation/translations/sp_SP/process/coding-style.rst <sp_codingstyle>`.
+   Verifique las infracciones triviales con el verificador de estilo de
+   parches antes de la entrega (``scripts/checkpatch.pl``).
+   Debería ser capaz de justificar todas las infracciones que permanezcan
+   en su parche.
+
+6) Cualquier opción ``CONFIG`` nueva o modificada no altera el menú de
+   configuración y se desactiva por defecto, a menos que cumpla con los
+   criterios de excepción documentados en
+   ``Documentation/kbuild/kconfig-language.rst`` Atributos del menú: valor por defecto.
+
+7) Todas las nuevas opciones de ``Kconfig`` tienen texto de ayuda.
+
+8) Ha sido revisado cuidadosamente con respecto a las combinaciones
+   relevantes de ``Kconfig``. Esto es muy difícil de hacer correctamente
+   con las pruebas -- la concentración mental da resultados aquí.
+
+9) Verifique limpiamente con sparse.
+
+10) Use ``make checkstack`` y solucione cualquier problema que encuentre.
+
+    .. note::
+
+       ``checkstack`` no señala los problemas explícitamente, pero
+       cualquier función que use más de 512 bytes en la pila es
+       candidata para el cambio.
+
+11) Incluya :ref:`kernel-doc <kernel_doc>` para documentar las API
+    globales del kernel. (No es necesario para funciones estáticas, pero
+    también está bien.) Utilice ``make htmldocs`` o ``make pdfdocs``
+    para comprobar el :ref:`kernel-doc <kernel_doc>` y solucionar
+    cualquier problema.
+
+12) Ha sido probado con ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
+    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
+    ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``
+    ``CONFIG_PROVE_RCU`` y ``CONFIG_DEBUG_OBJECTS_RCU_HEAD`` todos
+    habilitados simultáneamente.
+
+13) Ha sido probado en tiempo de compilación y ejecución con y sin
+    ``CONFIG_SMP`` y ``CONFIG_PREEMPT``.
+
+14) Todas las rutas de código se han ejercido con todas las
+    características de lockdep habilitadas.
+
+15) Todas las nuevas entradas de ``/proc`` están documentadas en
+    ``Documentation/``.
+
+16) Todos los nuevos parámetros de arranque del kernel están documentados
+    en ``Documentation/admin-guide/kernel-parameters.rst``.
+
+17) Todos los nuevos parámetros del módulo están documentados con
+    ``MODULE_PARM_DESC()``.
+
+18) Todas las nuevas interfaces de espacio de usuario están documentadas
+    en ``Documentation/ABI/``. Consulte ``Documentation/ABI/README`` para
+    obtener más información. Los parches que cambian las interfaces del
+    espacio de usuario deben ser CCed a linux-api@vger.kernel.org.
+
+19) Se ha comprobado con la inyección de al menos errores de asignación
+    de slab y página. Consulte ``Documentation/fault-injection/``.
+
+    Si el nuevo código es sustancial, la adición de la inyección de
+    errores específica del subsistema podría ser apropiada.
+
+20) El nuevo código añadido ha sido compilado con ``gcc -W`` (use
+    ``make KCFLAGS=-W``). Esto generara mucho ruido per es buena para
+    encontrar errores como "warning: comparison between signed and unsigned".
+
+21) Se prueba después de que se haya fusionado en el conjunto de
+    parches -mm para asegurarse de que siga funcionando con todos los
+    demás parches en cola y varios cambios en VM, VFS y otros subsistemas.
+
+22) Todas las barreras de memoria {p.ej., ``barrier()``, ``rmb()``,
+    ``wmb()``} necesitan un comentario en el código fuente que explique
+    la lógica de lo que están haciendo y por qué.
+
+23) Si se añaden algún ioctl en el parche, actualice también
+    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
+
+24) Si su código fuente modificado depende o utiliza cualquiera de las
+    API o características del kernel que están relacionadas con los
+    siguientes símbolos ``Kconfig`` entonces pruebe varias compilaciones
+    con los símbolos ``Kconfig`` relacionados deshabilitados y/o ``=m``
+    (si esa opción esta disponible) [no todos estos al mismo tiempo, solo
+    varias/aleatorias combinaciones de ellos]:
+
+    ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``, ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``
+    ``CONFIG_NET``, ``CONFIG_INET=n`` (pero luego con ``CONFIG_NET=y``).
-- 
2.34.1

