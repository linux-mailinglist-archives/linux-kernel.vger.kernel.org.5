Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7B7DCFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjJaPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjJaPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:13:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B185F3;
        Tue, 31 Oct 2023 08:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLC7SFo5/+h7U6dlyvnCnODCvOBrjwXSZg8tPh0gJJr+Ksq9TzdA5uxYQbwA63uDYS0fVaa1SqHknFX65hJzMGgL6TusJc2yusbuqdF/2KisT0VWuMBq2rFaYzhfbv+j4SDJxIrSdfF4czgwYkVu2CFDmZRr34zrVRTYfW9WqpY7j8x7z5TwmzdyHlAi2ZbxUk9S8jm0UTmrCgq5jsQEE8py8UEr25NbdmSDSfcx3ArAP2Kulr1dD4ZmSPO66k5ZINMtugzIg2qYDX+TS2vlPRRLiucGEg1jFZikEnsjdKe+wWqG4ZCaystRvAE3XDZXeDeFxG+Auw74DAVdZz84lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/myT1vVRflEmeKSO5Uz6UC73f6QKTy8KgtvakTK+63s=;
 b=Ezu5ESuOomhpu7tgwSvl9T6ja0EFSl2/v2+7aDwa8bkEpZ3V8LzJ03Qa0c623AvW7vG5fi6cuCCr+POD+yJbgPbgdKdfPajGN+rET9pmudUmWJBM4yq23QBvUu0FtOon6MqBlYlE9uE48Mz+lFx/Dk+kRPtGujL6UIRSo8W8OG8uNGNLSvLkjZPpZTkMHQi4ZHUbai6FpUT9GYmf4mLo6pHBWpsrJr9tmuuVD6OybAN8kVVKzRW0LOMwC0f0NjyvMW93YcKm4QKqGJLUExSHPWa/qy6iVfG6+FxneG9n8crChMsMg1633/UqBV/3PD7/2XeYtHKKMqxfkpoZ4AigAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/myT1vVRflEmeKSO5Uz6UC73f6QKTy8KgtvakTK+63s=;
 b=4tBUk7xdWQsD2RM+ZDoJPt+/frqnZE6bgmvF6AMG7sN3nL1X24xDd8LHvdkWpkbg8TtXkdFkmuw/wt0M2J3fC8HLcjjJJRoXKAiJYrZTNLHufDMEQ782l/89R0U3rqm21cjzheNHc7+d4TkSnS3lL+L/LqfmJVTO2Q22Ktc9E0g=
Received: from MW4PR03CA0210.namprd03.prod.outlook.com (2603:10b6:303:b8::35)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 15:13:29 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::1a) by MW4PR03CA0210.outlook.office365.com
 (2603:10b6:303:b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Tue, 31 Oct 2023 15:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.0 via Frontend Transport; Tue, 31 Oct 2023 15:13:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 10:13:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 10:13:26 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 31 Oct 2023 10:13:26 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sergio.collado@gmail.com>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs/sp_SP: Add translation of process/handling-regressions
Date:   Tue, 31 Oct 2023 10:13:25 -0500
Message-ID: <20231031151325.2903088-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: d08e1ce5-b797-4a69-e703-08dbda23efdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVLV5I/YLaUIhvSpbD/jBxLwNznXfHjRC/QlNo/mwGJ0x23lg9nal7zAm/y22Yf5cSvzs5YFuL2Fj4k7oVOqbzmckKycXHzVJs5Fu/MMwBzVxH7qKMPNVQAg5fnxOdrtzV2rhTJEyKcybuL0XpUXBv9YzyUORoCvNtZvveDYLQvK9hg2VQ3fAiw69oRoqlpeDMPz2Vv/TDOAB06tFX7eVfU/6OGzhZSkwlRtH6d03yNG82G99rPAbbxLg2iSaz4jJHRLi3i7Yg6QcYoZapO9XqWz3krLylGEXiYufIC/ReWgGnt7p45LidNj+ASeQouoH3yNQXT7VLMqs/PZQTNTsg1SCOos9JXLZ+wBwOQhR6BOw1WPb6B19m7Q3Ua8ff3sqwvNWBfr9CH7yyPfPNqoa4qBSGKqY1w9PM3rgmdTOXVDnFyO+NtuutUoWzjbFqdalM2mw2imSbQjJg3SmKimfhRL7/gsFE/zN168Y+CaIBfOLitRuPl5McQxfpaSKNGhoRAmO3UHkksTOdLq0Ic78Fc8jx7xJOyNK+x947yMd5tWieFTIrM1Ry8BrCWKlQCfFzksR7q0UCYPc4nQi2Qg5E4ACOJhK+FjB+ConW/TVc8llma/vpVzemruK7qHDZ1GWHm26LBTaGbnA0R3zJcyyz9NJKIFSJ9FCEo02Q2Z9SptH/jBJPa6QTCTDpSsHb0sud/rh3dzJoGvET4QbQ2iTpHBWeWYnvEebuCgJH6hvWuwqjdWhkyrNEnnH2OsRyhh4sFC7pPwodb3GOudZHSVhx8Fj/XAXDXLjQEDm83osR1RcauvlMzLyy8rrCo8lI0tgeM+OLPlkao4Ft8f9BjvaAsrsUZLhru+CKPsy3pIK0TtLSRvZNG6vYp+j3sm2HXJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(230473577357003)(230373577357003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(83380400001)(36756003)(66574015)(81166007)(1076003)(2616005)(26005)(356005)(36860700001)(82740400003)(41300700001)(47076005)(336012)(426003)(478600001)(4326008)(70206006)(6916009)(54906003)(70586007)(7696005)(8936002)(966005)(316002)(44832011)(2906002)(5660300002)(30864003)(8676002)(4001150100001)(40480700001)(40460700003)(66899024)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:13:28.4477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08e1ce5-b797-4a69-e703-08dbda23efdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/process/handling-regressions.rst into Spanish.

Co-developed-by: Sergio Gonzalez <sergio.collado@gmail.com>
Signed-off-by: Sergio Gonzalez <sergio.collado@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../sp_SP/process/handling-regressions.rst    | 797 ++++++++++++++++++
 .../translations/sp_SP/process/index.rst      |   1 +
 2 files changed, 798 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/handling-regressions.rst

diff --git a/Documentation/translations/sp_SP/process/handling-regressions.rst b/Documentation/translations/sp_SP/process/handling-regressions.rst
new file mode 100644
index 000000000000..aa0988985c55
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/handling-regressions.rst
@@ -0,0 +1,797 @@
+.. include:: ../disclaimer-sp.rst
+
+:Translator: Sergio González Collado <sergio.collado@gmail.com>
+
+.. _sp_handling_regressions:
+
+Gestión de regresiones
+++++++++++++++++++++++
+
+*No causamos regresiones* -- este documento describe la que es la "primera
+regla del desarrollo del kernel de Linux" y que implica en la práctica para
+los desarrolladores. Y complementa la documentación:
+Documentation/admin-guide/reporting-regressions.rst, que cubre el tema
+desde el punto de vista de un usuario; si nunca ha leído ese texto, realice
+al menos una lectura rápida del mismo antes de continuar.
+
+Las partes importantes (el "TL;DR")
+===================================
+
+#.  Asegúrese de que los suscriptores a la lista `regression mailing list
+    <https://lore.kernel.org/regressions/>`_ (regressions@lists.linux.dev)
+    son conocedores con rapidez de cualquier nuevo informe de regresión:
+
+    * Cuando se reciba un correo que no incluyó a la lista, inclúyalo en la
+      conversación de los correos, mandando un breve "Reply-all" con la
+      lista en CCed.
+
+    * Mande o redirija cualquier informe originado en los gestores de bugs
+      a la lista.
+
+#. Haga que el bot del kernel de Linux "regzbot" realice el seguimiento del
+   incidente (esto es opcional, pero recomendado).
+
+    * Para reportes enviados por correo, verificar si contiene alguna línea
+      como ``#regzbot introduced v5.13..v5.14-rc1``. Si no, mandar una
+      respuesta (con la lista de regresiones en CC) que contenga un párrafo
+      como el siguiente, lo que le indica a regzbot cuando empezó a suceder
+      el incidente::
+
+       #regzbot ^introduced 1f2e3d4c5b6a
+
+    * Cuando se mandan informes desde un gestor de incidentes a la lista de
+      regresiones(ver más arriba), incluir un párrafo como el siguiente::
+
+       #regzbot introduced: v5.13..v5.14-rc1
+       #regzbot from: Some N. Ice Human <some.human@example.com>
+       #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
+
+#. Cuando se manden correcciones para las regresiones, añadir etiquetas
+   "Link:" a la descripción, apuntado a todos los sitios donde se informó
+   del incidente, como se indica en el documento:
+   Documentation/process/submitting-patches.rst y
+   :ref:`Documentation/process/5.Posting.rst <development_posting>`.
+
+#. Intente arreglar las regresiones rápidamente una vez la causa haya sido
+   identificada; las correcciones para la mayor parte de las regresiones
+   deberían ser integradas en menos de dos semanas, pero algunas pueden
+   resolverse en dos o tres días.
+
+Detalles importantes para desarrolladores en la regresiones de kernel de Linux
+==============================================================================
+
+Puntos básicos importantes más en detalle
+-----------------------------------------
+
+Qué hacer cuando se recibe un aviso de regresión.
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Asegúrese de que el programa de gestión de regresiones del kernel de Linux
+y los subscritos a la lista de correo `regression mailing list
+<https://lore.kernel.org/regressions/>`_ (regressions@lists.linux.dev) son
+conocedores de cualquier nuevo informe de regresión:
+
+ * Cuando se recibe un informe por email que no tiene en CC la lista,
+   inmediatamente meterla en el la cadena de emails mandado al menos un
+   breve "Reply-all" con la lista en CC; Intentar asegurar que la lista es
+   añadida en CC de nuevo en caso de que alguna respuesta la omita de la
+   lista.
+
+ * Si un informe enviado a un gestor de defectos, llega a su correo,
+   reenvíelo o redirijalo a la lista. Considere verificar los archivos de
+   la lista de antemano, si la persona que lo ha informado, lo ha enviado
+   anteriormente, como se indica en:
+   Documentation/admin-guide/reporting-issues.rst.
+
+Cuando se realice cualquiera de las acciones anteriores, considere
+inmediatamente iniciar el seguimiento de la regresión con "regzbot" el
+gestor de regresiones del kernel de Linux.
+
+ * Para los informes enviados por email, verificar si se ha incluido un
+   comando a "regzbot", como ``#regzbot introduced 1f2e3d4c5b6a``. Si no es
+   así, envíe una respuesta (con la lista de regresiones en CC) con un
+   párrafo como el siguiente::
+
+       #regzbot ^introduced: v5.13..v5.14-rc1
+
+   Esto indica a regzbot el rango de versiones en el cual es defecto
+   comenzó a suceder; Puede especificar un rango usando los identificadores
+   de los commits así como un único commit, en caso en el que el informante
+   haya identificado el commit causante con 'bisect'.
+
+   Tenga en cuenta que el acento circunflejo (^) antes de "introduced":
+   Esto indica a regzbot, que debe tratar el email padre (el que ha sido
+   respondido) como el informeinicial para la regresión que quiere ser
+   seguida. Esto es importante, ya que regzbot buscará más tarde parches
+   con etiquetas "Link:" que apunten al al informe de losarchivos de
+   lore.kernel.org.
+
+ * Cuando mande informes de regresiones a un gestor de defectos, incluya un
+   párrafo con los siguientes comandos a regzbot::
+
+       #regzbot introduced: 1f2e3d4c5b6a
+       #regzbot from: Some N. Ice Human <some.human@example.com>
+       #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
+
+   Regzbot asociará automáticamente parches con el informe que contengan
+   las etiquetas "Link:" apuntando a su email o el ticket indicado.
+
+Qué es importante cuando se corrigen regresiones
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+No se necesita hacer nada especial cuando se mandan las correcciones para
+las regresiones únicamente recordar lo que se explica en los documentos:
+Documentation/process/submitting-patches.rst,
+:ref:`Documentation/process/5.Posting.rst <development_posting>`, y
+Documentation/process/stable-kernel-rules.rst
+
+ * Apunte a todos los lugares donde el incidente se reportó usando la
+   etiqueta "Link:" ::
+
+       Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+       Link: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890
+
+ * Añada la etiqueta "Fixes:" para indicar el commit causante de la
+   regresión.
+
+ * Si el culpable ha sido "mergeado" en un ciclo de desarrollo anterior,
+   marque explícitamente el fix para retro-importarlo usando la etiqueta
+   ``Cc: stable@vger.kernel.org`` tag.
+
+Todo esto se espera y es importante en una regresión, ya que estas
+etiquetas son de gran valor para todos (incluido usted) que pueda estar
+mirando en ese incidente semanas, meses o años después. Estas etiquetas son
+también cruciales para las herramientas y scripts usados por otros
+desarrolladores del kernel o distribuciones de Linux; una de esas
+herramientas es regzbot, el cual depende mucho de las etiquetas "Link:"
+para asociar los informes por regresiones con los cambios que las
+resuelven.
+
+
+Priorización del trabajo en arreglar regresiones
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Al final, los desarrolladores deberían hacer lo posible para evitar a los
+usuarios situaciones donde una regresión les deje solo tres opciones:
+
+ * Ejecutar el kernel con una regresión que afecta seriamente al uso.
+
+ * Cambiar a un kernel nuevo o mas antiguo -- rebajarse a una versión
+   soportada del kernel que no tenga las funcionalidades requeridas.
+
+ * Continuar ejecutando una versión desfasada y potencialmente insegura del
+   kernel por más de dos semanas después de que el causante de una regresión
+   fuese identificado.
+
+Cómo se ejecuta esto depende mucho de la situación. A continuación se
+presentan unas reglas generales, en orden de importancia:
+
+ * Priorice el trabajo en la gestión de los informes de la regresión y
+   arreglar la regresión por encima de cualquier otro trabajo en el kernel
+   de Linux, a menos que lo último afecte profundamente a efectos de
+   seguridad, o cause errores en los que haya pérdida o daño de datos.
+
+ * Considere siempre revertir los commits responsables y re-aplicarlos
+   después, junto con las correcciones necesarias, ya que esto puede la
+   forma menos peligrosa y más rápida de arreglar la regresión.
+
+ * Los desarrolladores deberían gestionar la regresión en todos los kernels
+   soportados de la serie, pero son libres de delegar el trabajo al equipo
+   permanente el incidente no hubiese ocurrido en la línea principal.
+
+ * Intente resolver cualquier regresión que apareciera en el ciclo de
+   desarrollo antes de que este acabe. Si se teme que una corrección
+   pudiera ser demasiado arriesgada para aplicarla días antes de una
+   liberación de la línea principal de desarrollo, dejar decidir a Linus:
+   mande la corrección a él de forma separada, tan pronto como sea posible
+   con una explicación de la situación. El podrá decidir, y posponer la
+   liberación si fuese necesario, por ejemplo si aparecieran múltiples
+   cambios como ese.
+
+ * Gestione las regresiones en la rama estable, de largo término, o la
+   propia rama principal de las versiones, con más urgencia que la
+   regresiones en las preliberaciones. Esto cambia después de la liberación
+   de la quinta pre-liberación, aka "-rc5": la rama principal entonces se
+   vuelve más importante, asegurar que todas las mejoras y correcciones son
+   idealmente testeados juntos por al menos una semana antes de que Linux
+   libere la nueva versión en la rama principal.
+
+ * Intente arreglar regresiones en un intervalo de una semana después de
+   que se ha identificado el responsable, si el incidente fue introducido
+   en alguno de los siguientes casos:
+
+    * una versión estable/largo-plazo reciente
+
+    * en el último ciclo de desarrollo de la rama principal
+
+   En el último caso (por ejemplo v5.14), intentar gestionar las
+   regresiones incluso más rápido, si la versión estable precedente (v5.13)
+   ha de ser abandonada pronto o ya se ha etiquetado como de final de vida
+   (EOL de las siglas en inglés End-of-Life) -- esto sucede usualmente
+   sobre tres o cuatro semanas después de una liberación de una versión en
+   la rama principal.
+
+ * Intente arreglar cualquier otra regresión en un periodo de dos semanas
+   después de que el culpable haya sido identificado. Dos o tres semanas
+   adicionales son aceptables para regresiones de rendimiento y otros
+   incidentes que son molestos, pero no bloquean a nadie la ejecución de
+   Linux (a menos que se un incidente en el ciclo de desarrollo actual, en
+   ese caso se debería gestionar antes de la liberación de la versión).
+   Unas semanas son aceptables si la regresión únicamente puede ser
+   arreglada con un cambio arriesgado y al mismo tiempo únicamente afecta a
+   unos pocos usuarios; también está bien si se usa tanto tiempo como fuera
+   necesario si la regresión está presente en la segunda versión más nueva
+   de largo plazo del kernel.
+
+Nota: Los intervalos de tiempo mencionados anteriormente para la resolución
+de las regresiones, incluyen la verificación de esta, revisión e inclusión
+en la rama principal, idealmente con la corrección incluida en la rama
+"linux-next" al menos brevemente. Esto conllevará retrasos que también se
+tienen tener en cuenta.
+
+Se espera que los maintainers de los subsistemas, ayuden en conseguir esos
+tiempos, haciendo revisiones con prontitud y gestionando con rapidez los
+parches aceptados. Esto puede resultar en tener que mandar peticiones de
+git-pull antes o de forma más frecuente que lo normal; dependiendo del
+arreglo, podría incluso ser aceptable saltarse la verificación en
+linux-next. Especialmente para las correcciones en las ramas de los kernels
+estable y de largo plazo necesitan ser gestionadas rápidamente, y las
+correcciones necesitan ser incluidas en la rama principal antes de que
+puedan ser incluidas posteriormente a las series precedentes.
+
+
+Más aspectos sobre regresiones que los desarrolladores deben saber
+------------------------------------------------------------------
+
+Cómo tratar con cambios donde se sabe que hay riesgo de regresión
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Evalué cómo de grande es el riesgo de una regresión, por ejemplo realizando
+una búsqueda en las distribuciones de linux y en Git forges. Considere
+también preguntar a otros desarrolladores o proyectos que pudieran ser
+afectados para evaluar o incluso testear el cambio propuesto; si
+apareciesen problemas, quizás se pudiera encontrar una solución aceptable
+para todos.
+
+Si al final, el riesgo de la regresión parece ser relativamente pequeño,
+entonces adelante con el cambio, pero siempre informe a todas las partes
+involucradas del posible riesgo. Por tanto, asegúrese de que la descripción
+del parche, se hace explícito este hecho. Una vez el cambio ha sido
+integrado, informe al gestor de regresiones de Linux y a las listas de
+correo de regresiones sobre el riesgo, de manera que cualquiera que tenga
+el cambio en el radar, en el caso de que aparezcan reportes. Dependiendo
+del riesgo, quizás se quiera preguntar al mantenedor del subsistema, que
+mencione el hecho en su línea principal de desarrollo.
+
+¿Qué más hay que saber sobre regresiones?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Repase la documentación: Documentation/admin-guide/reporting-regressions.rst,
+esta cubre otros aspectos a tener a en cuenta y conocer:
+
+ * la finalidad de la "regla de no regresión"
+
+ * qué incidencias no se califican como regresión
+
+ * quién es el responsable de identificar la causa raíz de una regresión
+
+ * cómo gestionar situaciones difíciles, como por ejemplo cuando una
+   regresión es causada por una corrección de seguridad o cuando una
+   regresión causa otra regresión
+
+A quién preguntar por consejo cuando se trata de regresiones
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Mande un email a la lista de correo de regresiones
+(regressions@lists.linux.dev) y CC al seguidor de regresiones del kernel de
+Linux (regressions@leemhuis.info); Si el incidente pudiera ser mejor
+gestionarlo en privado, puede omitirse la lista.
+
+
+Más sobre la gestión de regresiones con regzbot
+-----------------------------------------------
+
+¿Por qué el kernel de Linux tiene un gestor de regresiones, y por qué se usa regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Reglas como "no regresiones" necesitan asegurar que se cumplen, de otro
+modo se romperían accidentalmente o a propósito. La historia ha mostrado
+que esto es verdad también para el kernel de Linux. Esto es por lo que
+Thorsten Leemhuis se ofreció como voluntario para dar una solución a esto,
+con el gestor de regresiones del kernel de Linux. A nadie se le paga por
+hacer esto, y esa es la razón por la gestión de regresiones es un servicio
+con el "mejor esfuerzo".
+
+Intentos iniciales de gestionar manualmente las regresiones han demostrado
+que es una tarea extenuante y frustrante, y por esa razón se dejaron de
+hacer después de un tiempo. Para evitar que volviese a suceder esto,
+Thorsten desarrollo regbot para facilitar el trabajo, con el objetivo a
+largo plazo de automatizar la gestión de regresiones tanto como fuese
+posible para cualquiera que estuviese involucrado.
+
+¿Cómo funciona el seguimiento de regresiones con regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+El bot monitoriza las respuestas de los informes de las regresiones
+identificadas. Adicionalmente mira si se han publicado o enviado parches
+que hagan referencia a esos informes con la etiqueta: "Link:"; respuestas a
+esos parches también se siguen. Combinando esta información, también
+proporciona una buena imagen del estado actual del proceso de corrección.
+
+Regzbot intenta hacer todo este trabajo con tan poco retraso como sea
+posible tanto para la gente que lo reporta, como para los desarrolladores.
+De hecho, solo los informantes son requeridos para una tarea adicional:
+necesitan informar a regzbot con el comando ``#regzbot introduced``
+indicado anteriormente; si no hacen esto, alguien más puede hacerlo usando
+``#regzbot ^introduced``.
+
+Para los desarrolladores normalmente no hay un trabajo adicional que
+realizar, únicamente necesitan asegurarse una cosa, que ya se hacía mucho
+antes de que regzbot apareciera: añadir las etiquetas "Link:" a la
+descripción del parche apuntando a todos los informes sobre el error
+corregido.
+
+¿Tengo que usar regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Hacerlo es por el bien de todo el mundo, tanto los mantenedores del kernel,
+como Linus Torvalds dependen parcialmente en regzbot para seguir su trabajo
+-- por ejemplo cuando deciden liberar una nueva versión o ampliar la fase de
+desarrollo. Para esto necesitan conocer todas las regresiones que están sin
+corregir; para esto, es conocido que Linux mira los informes semanales que
+manda regzbot.
+
+¿He de informar a regzbot cada regresión que encuentre?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Idealmente, sí: todos somos humanos y olvidamos fácilmente los problemas
+cuando algo más importante aparece inesperadamente -- por ejemplo un
+problema mayor en el kernel de Linux o algo en la vida real que nos mantenga
+alejados de los teclados por un tiempo. Por eso es mejor informar a regzbot
+sobre cada regresión, excepto cuando inmediatamente escribimos un parche y
+los mandamos al árbol de desarrollo en el que se integran habitualmente a
+la serie del kernel.
+
+¿Cómo ver qué regresiones esta siguiendo regbot actualmente?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Verifique el `interfaz web de regzbot <https://linux-regtracking.leemhuis.info/regzbot/>`_
+para ver la última información; o `busque el último informe de regresiones
+<https://lore.kernel.org/lkml/?q=%22Linux+regressions+report%22+f%3Aregzbot>`_,
+el cual suele ser enviado por regzbot una vez a la semana el domingo por la
+noche (UTC), lo cual es unas horas antes de que Linus normalmente anuncie
+las "(pre-)releases".
+
+¿Qué sitios supervisa regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Regzbot supervisa las listas de correo más importantes de Linux, como
+también las de los repositorios linux-next, mainline y stable/longterm.
+
+
+¿Qué tipos de incidentes han de ser monitorizados por regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+El bot debe hacer seguimiento de las regresiones, y por tanto por favor,
+no involucre a regzbot para incidencias normales. Pero es correcto para
+el gestor de incidencias de kernel de Linux, monitorizar incidentes
+graves, como informes sobre cuelgues, corrupción de datos o errores
+internos (Panic, Oops, BUG(), warning, ...).
+
+
+¿Puedo añadir una regresión detectada por un sistema de CI al seguimiento de regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Siéntase libre de hacerlo, si la regresión en concreto puede tener un
+impacto en casos de uso prácticos y por tanto ser detectado por los usuarios;
+Así, por favor no involucre a regzbot en regresiones teóricas que
+difícilmente pudieran manifestarse en un uso real.
+
+¿Cómo interactuar con regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Usando el comando 'regzbot' en una respuesta directa o indirecta al correo
+con el informe de regresión. Ese comando necesita estar en su propio
+párrafo (debe estar separado del resto del texto usando líneas en blanco):
+
+Por ejemplo ``#regzbot introduced <version or commit>``, que hace que regzbot
+considere el correo como un informe de regressión que se ha de añadir al
+seguimiento, como se ha descrito anteriormente; ``#regzbot ^introduced <version or commit>``
+es otro ejemplo del comando, el cual indica a regzbot que considere el email
+anterior como el informe de una regresión que se ha de comenzar a monitorizar.
+
+Una vez uno de esos dos comandos se ha utilizado, se pueden usar otros
+comandos regzbot en respuestas directas o indirectas al informe. Puede
+escribirlos debajo de uno de los comandos anteriormente usados o en las
+respuestas al correo en el que se uso como respuesta a ese correo:
+
+ * Definir o actualizar el título::
+
+       #regzbot title: foo
+
+ * Monitorizar una discusión o un tiquet de bugzilla.kernel.org donde
+   aspectos adicionales del incidente o de la corrección se están
+   comentando -- por ejemplo presentar un parche que corrige la regresión::
+
+       #regzbot monitor: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
+
+  Monitorizar solamente funciona para lore.kernel.org y bugzilla.kernel.org;
+  regzbot considerará todos los mensajes en ese hilo o el tiquet como
+  relacionados al proceso de corrección.
+
+ * Indicar a un lugar donde más detalles de interés, como un mensaje en una
+   lista de correo o un tiquet en un gestor de incidencias que pueden estar
+   levemente relacionados, pero con un tema diferente::
+
+       #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=123456789
+
+ * Identificar una regresión como corregida por un commit que se ha mandado
+   aguas arriba o se ha publicado::
+
+        #regzbot fixed-by: 1f2e3d4c5d
+
+
+ * Identificar una regresión como un duplicado de otra que ya es seguida
+   por regzbot::
+
+        #regzbot dup-of: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
+
+ * Identificar una regresión como inválida::
+
+       #regzbot invalid: wasn't a regression, problem has always existed
+
+
+¿Algo más que decir sobre regzbot y sus comandos?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Hay información más detallada y actualizada sobre el bot de seguimiento de
+regresiones del kernel de Linux en: `project page <https://gitlab.com/knurd42/regzbot>`_,
+y entre otros contiene una  `guia de inicio <https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md>`_
+y `documentación de referencia <https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md>`_
+Ambos contienen más detalles que las secciones anteriores.
+
+
+Citas de Linus sobre regresiones
+--------------------------------
+
+A continuación se encuentran unos ejemplos reales (traducidos) de como
+Linus Torvalds espera que se gestionen las regresiones:
+
+
+ * De 2017-10-26 (1/2)
+   <https://lore.kernel.org/lkml/CA+55aFwiiQYJ+YoLKCXjN_beDVfu38mg=Ggg5LFOcqHE8Qi7Zw@mail.gmail.com/>`_::
+
+     Si rompes la configuración de los espacios de usuario ESO ES UNA REGRESIÓN.
+
+     No está bien decir "pero nosotros arreglaremos la configuración del espacio
+     de usuario".
+
+     Realmente. NO ESTÁ BIEN.
+
+     [...]
+
+     La primera regla es:
+
+     - no causamos regresiones
+
+     y el corolario es que cuando una regresión pasa, lo admitimos y lo
+     arreglamos, en vez de echar la culpa al espacio de usuario.
+
+     El hecho de que aparentemente se haya negado la regresión durante
+     tres semanas, significa que lo revertiré y dejaré de integrar peticiones
+     de apparmor hasta que la gente involucrada entienda como se hace
+     el desarrollo del kernel.
+
+
+ * De `2017-10-26 (2/2)
+   <https://lore.kernel.org/lkml/CA+55aFxW7NMAMvYhkvz1UPbUTUJewRt6Yb51QAx5RtrWOwjebg@mail.gmail.com/>`_::
+
+       La gente debería sentirse libre de actualizar su kernel y simplemente
+       no preocuparse por ello.
+
+       Me niego a imponer una limitación del tipo "solo puede actualizar
+       el kernel si actualiza otro programa". Si el kernel trabaja para tí,
+       la regla es que continúe trabajando para tí.
+
+       Ha habido algunas excepciones, pero son pocas y separadas entre sí, y
+       generalmente tienen una razón fundamental para haber sucedido, que era
+       básicamente inevitable, y la gente intentó evitarlas por todos los
+       medios. Quizás no podamos mantener el hardware más, después de que han
+       pasado décadas y nadie los usacon kernel modernos. Quizás haya un
+       problema de seguridad serio con cómo hicimos las cosas, y la gente
+       depende de un modelo fundamentalmente roto. Quizás haya algún otro roto
+       fundamental, que tenga que tener una _flag_ y por razones internas y
+       fundamentales.
+
+       Y nótese que esto trata sobre *romper* los entornos de la gente.
+
+       Cambios de comportamiento pasan, y quizás no se mantengan algunas
+       funcionalidades más. Hay un número de campos en /proc/<pid>/stat que
+       se imprimen como ceros, simplemente porque ni siquiera existen ya en
+       kernel, o porque mostrarlos era un error (típica una fuga de
+       información). Pero los números se sustituyeron por ceros, así que
+       el código que se usaba para parsear esos campos todavía existe. El
+       usuario puede no ver todo lo que podía ver antes, y por eso el
+       omportamiento es claramente diferente, pero las cosas todavía
+       _funcionan_, incluso si no se puede mostrar información sensible
+       (o que no es ya importante).
+
+       Pero si algo realmente se rompe, entonces el cambio debe de arreglarse
+       o revertirse. Y se arregla en el *kernel*. No diciendo "bueno, arreglaremos
+       tu espacio de usuario". Ha sido un cambio en el kernel el que creo
+       el problema, entonces ha de ser el kernel el que lo corrija, porque
+       tenemos un modelo de "actualización". Pero no tenemos una "actualización
+       con el nuevo espacio de usuario".
+
+       Y yo seriamente me negaré a coger código de gente que no entiende y
+       honre esta sencilla regla.
+
+       Y esta regla no va a cambiar.
+
+       Y sí, me doy cuenta que el kernel es "especial" en este respecto. Y
+       estoy orgulloso de ello.
+
+       Y he visto, y puedo señalar, muchos proyectos que dicen "Tenemos que
+       romper ese caso de uso para poder hacer progresos" o "estabas basandote
+       en comportamientos no documentados, debe ser duro ser tú" o "hay una
+       forma mejor de hacer lo que quieres hacer, y tienes que cambiar a esa
+       nueva forma", y yo simplemente no pienso que eso sea aceptable fuera
+       de una fase alfa muy temprana que tenga usuarios experimentales que
+       saben a lo que se han apuntado. El kernel no ha estado en esta
+       situación en las dos últimas décadas.
+
+       Nosotros rompemos la API _dentro_ del kernel todo el tiempo. Y
+       arreglaremos los problemas internos diciendo "tú ahora necesitas
+       hacer XYZ", pero entonces es sobre la API interna del kernel y la
+       gente que hace esto entonces tendrá obviamente que arreglar todos
+       los usos de esa API del kernel. Nadie puede decir "ahora, yo he roto
+       la API que usas, y ahora tú necesitas arreglarlo". Quién rompa algo,
+       lo arregla también.
+
+       Y nosotros, simplemente, no rompemos el espacio de usuario.
+
+ * De `2020-05-21
+   <https://lore.kernel.org/all/CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com/>`_::
+
+       Las reglas sobre regresiones nunca han sido sobre ningún tipo de
+       comportamiento documentado, o dónde está situado el código.
+
+       Las reglas sobre regresiones son siempre sobre "roturas en el
+       flujo de trabajo del usuario".
+
+       Los usuarios son literalmente la _única_ cosa que importa.
+
+       Argumentaciones como "no debería haber usado esto" o "ese
+       comportamiento es indefinido, es su culpa que su aplicación no
+       funcione" o "eso solía funcionar únicamente por un bug del kernel" son
+       irrelevantes.
+
+       Ahora, la realidad nunca es blanca o negra. Así hemos tenido situaciones
+       como "un serio incidente de seguridad" etc que solamente nos fuerza
+       a hacer cambios que pueden romper el espacio de usuario. Pero incluso
+       entonces la regla es que realmente no hay otras opciones para que
+       las cosas sigan funcionando.
+
+       Y obviamente, si los usuarios tardan años en darse cuenta que algo
+       se ha roto, o si hay formas adecuadas para sortear la rotura que
+       no causen muchos problemas para los usuarios (por ejemplo: "hay un
+       puñado de usuarios, y estos pueden usar la línea de comandos del
+       kernel para evitarlos"; ese tipo de casos), en esos casos se ha sido
+       un poco menos estricto.
+
+       Pero no, "eso que está documentado que está roto" (si es dado a que
+       el código estaba en preparación o porque el manual dice otra cosa) eso
+       es irrelevante. Si preparar el código es tan útil que la gente,
+       acaba usando, esto implica que básicamente es código del kernel con
+       una señal diciendo "por favor limpiar esto".
+
+       El otro lado de la moneda es que la gente que habla sobre "estabilidad
+       de las APIs" están totalmente equivocados. Las APIs tampoco importan.
+       Se puede hacer cualquier cambio que se quiera a una API ... siempre y
+       cuando nadie se de cuenta.
+
+       De nuevo, la regla de las regresiones no trata sobre la documentación,
+       tampoco sobre las APIs y tampoco sobre las fases de la Luna.
+
+       Únicamente trata sobre "hemos causado problemas al espacio de usuario que
+       antes funcionaba".
+
+ * De `2017-11-05
+   <https://lore.kernel.org/all/CA+55aFzUvbGjD8nQ-+3oiMBx14c_6zOj2n7KLN3UsJ-qsd4Dcw@mail.gmail.com/>`_::
+
+       Y nuestra regla sobre las regresiones nunca ha sido "el comportamiento
+       no cambia". Eso podría significar que nunca podríamos hacer ningún
+       cambio.
+
+       Por ejemplo, hacemos cosas como añadir una nueva gestión de
+       errores etc todo el tiempo, con lo cual a veces incluso añadimos
+       tests en el directorio de kselftest.
+
+       Así que claramente cambia el comportamiento todo el tiempo y
+       nosotros no consideramos eso una regresión per se.
+
+       La regla para regresiones para el kernel es para cuando se
+       rompe algo en el espacio de usuario. No en algún test. No en
+       "mira, antes podía hacer X, y ahora no puedo".
+
+ * De `2018-08-03
+   <https://lore.kernel.org/all/CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com/>`_::
+
+       ESTÁS OLVIDANDO LA REGLA #1 DEL KERNEL.
+
+       No hacemos regresiones, y no hacemos regresiones porque estás 100%
+       equivocado.
+
+       Y la razón que apuntas en tú opinión es exactamente *PORQUÉ* estás
+       equivocado.
+
+       Tus "buenas razones" son honradas y pura basura.
+
+       El punto de "no hacemos regresiones" es para que la gente pueda
+       actualizar el kernel y nunca tengan que preocuparse por ello.
+
+       > El kernel tiene un bug que ha de ser arreglado
+
+       Eso es *TOTALMENTE* insustancial.
+
+       Chicos, si algo estaba roto o no, NO IMPORTA.
+
+       ¿Porqué?
+
+       Los errores pasan. Eso es un hecho de la vida. Discutir que
+       "tenemos que romper algo porque estábamos arreglando un error" es
+       una locura. Arreglamos decenas de errores cada dia, pensando que
+       "arreglando un bug" significa que podemos romper otra cosa es algo
+       que simplemente NO ES VERDAD.
+
+       Así que los bugs no son realmente relevantes para la discusión. Estos
+       suceden y se detectan, se arreglan, y no tienen nada que ver con
+       "rompemos a los usuarios".
+
+       Porque la única cosa que importa ES EL USUARIO.
+
+       ¿Cómo de complicado es eso de comprender?
+
+       Cualquier persona que use "pero no funcionaba correctamente" es
+       un argumento no tiene la razón. Con respecto al USUARIO, no era
+       erróneo - funcionaba para él/ella.
+
+       Quizás funcionaba *porque* el usuario había tenido el bug en cuenta,
+       y quizás funcionaba porque el usuario no lo había notado - de nuevo
+       no importa. Funcionaba para el usuario.
+
+       Romper el flujo del trabajo de un usuario, debido a un "bug" es la
+       PEOR razón que se pueda usar.
+
+       Es básicamente decir "He cogido algo que funcionaba, y lo he roto,
+       pero ahora es mejor". ¿No ves que un argumento como este es j*didamente
+       absurdo?
+
+       y sin usuarios, tu programa no es un programa, es una pieza de
+       código sin finalidad que puedes perfectamente tirar a la basura.
+
+       Seriamente. Esto es *porque* la regla #1 para el desarrollo del
+       kernel es "no rompemos el espacio de usuario". Porque "He arreglado
+       un error" PARA NADA ES UN ARGUMENTO si esa corrección del código
+       rompe el espacio de usuario.
+
+       si actualizamos el kernel TODO EL TIEMPO, sin actualizar ningún otro
+       programa en absoluto. Y esto es absolutamente necesario, porque
+       las dependencias son terribles.
+
+       Y esto es necesario simplemente porque yo como desarrollador del
+       kernel no actualizo al azar otras herramientas que ni siquiera me
+       importan como desarrollador del kernel, y yo quiero que mis usuarios
+       se sientan a salvo haciendo lo mismo.
+
+       Así que no. Tu regla está COMPLETAMENTE equivocada. Si no puedes
+       actualizar el kernel sin actualizar otro binario al azar, entonces
+       tenemos un problema.
+
+ * De `2021-06-05
+   <https://lore.kernel.org/all/CAHk-=wiUVqHN76YUwhkjZzwTdjMMJf_zN4+u7vEJjmEGh3recw@mail.gmail.com/>`_::
+
+       NO HAY ARGUMENTOS VÁLIDOS PARA UNA REGRESIÓN.
+
+       Honestamente, la gente de seguridad necesita entender que "no funciona"
+       no es un caso de éxito sobre seguridad. Es un caso de fallo.
+
+       Sí, "no funciona" puede ser seguro. Pero en este caso es totalmente
+       inutil.
+
+ * De `2011-05-06 (1/3)
+   <https://lore.kernel.org/all/BANLkTim9YvResB+PwRp7QTK-a5VNg2PvmQ@mail.gmail.com/>`_::
+
+       La compatibilidad de los binarios es más importante.
+
+       Y si los binarios no usan el interfaz para parsear el formato
+       (o justamente lo parsea incorrectamente - como el reciente ejemplo
+       de añadir uuid al /proc/self/mountinfo), entonces es una regresión.
+
+       Y las regresiones se revierten, a menos que haya problemas de
+       seguridad o similares que nos hagan decir "Dios mío, realmente
+       tenemos que romper las cosas".
+
+       No entiendo porqué esta simple lógica es tan difícil para algunos
+       desarrolladores del kernel. La realidad importa. Sus deseos personales
+       NO IMPORTAN NADA.
+
+       Si se crea un interface que puede usarse sin parsear la
+       descripción del interface, entonces estaḿos atascados en el interface.
+       La teoría simplemente no importa.
+
+       Podrias alludar a arreglar las herramientas, e intentar evitar los
+       errores de compatibilidad de ese modo. No hay tampoco tantos de esos.
+
+   De `2011-05-06 (2/3)
+   <https://lore.kernel.org/all/BANLkTi=KVXjKR82sqsz4gwjr+E0vtqCmvA@mail.gmail.com/>`_::
+
+       Esto claramente NO es un tracepoint interno. Por definición. Y está
+       siendo usado por powertop.
+
+   De `2011-05-06 (3/3)
+   <https://lore.kernel.org/all/BANLkTinazaXRdGovYL7rRVp+j6HbJ7pzhg@mail.gmail.com/>`_::
+
+       Tenemos programas que usan esa ABI y si eso se rompe eso es una
+       regresión.
+
+ * De `2012-07-06 <https://lore.kernel.org/all/CA+55aFwnLJ+0sjx92EGREGTWOx84wwKaraSzpTNJwPVV8edw8g@mail.gmail.com/>`_::
+
+       > Ahora esto me ha dejado preguntandome si Debian _inestable_
+       realmente califica
+       > como espacio de usuario estándar.
+
+       Oh, si el kernel rompe algún espacio de usuario estándar, eso cuenta.
+       Muchísima gente usa Debian inestable.
+
+ * De `2019-09-15
+   <https://lore.kernel.org/lkml/CAHk-=wiP4K8DRJWsCo=20hn_6054xBamGKF2kPgUzpB5aMaofA@mail.gmail.com/>`_::
+
+       Una reversión _en particular_ en el último minuto en el último commit
+       (no teniendo en cuenta el propio cambio de versión) justo antes
+       de la liberación, y aunque es bastante incómodo, quizás también es
+       instructivo.
+
+       Lo que es instructivo sobre esto es que he revertido un commit que no
+       tenía ningún error. De hecho, hacía exactamente lo que pretendía, y lo
+       hacía muy bien. De hecho lo hacía _tan_ bien que los muy mejorados
+       patrones de IO que causaba han acabado revelando una regresión observable
+       desde el espacio de usuario, debido a un error real en un componente
+       no relacionado en absoluto.
+
+       De todas maneras, los detalles actuales de esta regresión no son la
+       razón por la que señalo esto como instructivo. Es más que es un ejemplo
+       ilustrativo sobre lo que cuenta como una regresión, y lo que conlleva
+       la regla del kernel de "no regresiones". El commit que ha sido revertido
+       no cambiaba ninguna API, y no introducía ningún error nuevo en el código.
+       Pero acabó exponiendo otro problema, y como eso causaba que la
+       actualización del kernel fallara para el usuario. Así que ha sido
+       revertido.
+
+       El foco aquí, es que hemos hecho la reversión basándonos en el
+       comportamiento reportado en el espacio de usuario, no basado en
+       conceptos como "cambios de ABI" o "provocaba un error". Los mejores
+       patrones de IO que se han presentado debido al cambio únicamente han
+       expuesto un viejo error, y la gente ya dependía del benigno
+       comportamiento de ese viejo error.
+
+       Y que no haya miedo, reintroduciremos el arreglo que mejoraba los
+       patrones de IO una vez hayamos decidido cómo gestionar el hecho de
+       que hay una interacción incorrecta con un interfaz en el que la
+       gente dependía de ese comportamiento previo. Es únicamente que
+       tenemos que ver cómo gestionamos y cómo lo hacemos (no hay menos de
+       tres parches diferentes de tres desarrolladores distintos que estamos
+       evaluando, ... puede haber más por llegar). Mientras tanto, he
+       revertido lo que exponía el problema a los usuarios de esta release,
+       incluso cuando espero que el fix será reintroducido (quizás insertado
+       a posteriormente como un parche estable) una vez lleguemos a un
+       acuerdo sobre cómo se ha de exponer el error.
+
+       Lo que hay que recordar de todo el asunto no es sobre si el cambio
+       de kernel-espacio-de-usuario ABI, o la corrección de un error, o si
+       el código antiguo "en primer lugar nunca debería haber estado ahí".
+       Es sobre si algo rompe el actual flujo de trabajo del usuario.
+
+       De todas formas, esto era mi pequeña aclaración en todo este
+       tema de la regresión. Ya que es la "primera regla de la programación
+       del kernel", me ha parecido que quizás es bueno mencionarlo de
+       vez en cuando.
diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index d6f3ccfb160e..a082e162168a 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -24,3 +24,4 @@
    contribution-maturity-model
    security-bugs
    embargoed-hardware-issues
+   handling-regressions
-- 
2.34.1

